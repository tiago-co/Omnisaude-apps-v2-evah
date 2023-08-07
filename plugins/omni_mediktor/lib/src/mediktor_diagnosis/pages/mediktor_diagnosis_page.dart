import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_mediktor/src/core/enums/mediktor_urgency_enum.dart';
import 'package:omni_mediktor/src/core/models/recomendation_model.dart';
import 'package:omni_mediktor/src/core/models/token_mediktor_model.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/mediktor_diagnosis_store.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/stores/mediktor_recomendation_store.dart';
import 'package:omni_mediktor_labels/labels.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MediktorDiagnosisPage extends StatefulWidget {
  final String moduleName;

  const MediktorDiagnosisPage({
    Key? key,
    required this.moduleName,
  }) : super(key: key);
  @override
  MediktorDiagnosisPageState createState() => MediktorDiagnosisPageState();
}

class MediktorDiagnosisPageState extends State<MediktorDiagnosisPage> {
  final MediktorDiagnosisStore store = Modular.get();
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final MediktorRecomendationStore recomendationStore =
      Modular.get<MediktorRecomendationStore>();
  final BaseUrlStore baseUrlStore = Modular.get();
  String _buttonText = 'Continuar';

  @override
  void initState() {
    if (store.state.authToken == null) {
      store.authenticate();
    }
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.moduleName).build(context) as AppBar,
      resizeToAvoidBottomInset: true,
      body: TripleBuilder<MediktorDiagnosisStore, DioError, TokenMediktorModel>(
        store: store,
        builder: (_, triple) {
          final String url = '${baseUrlStore.mediktorUrl}/?lang=pt_BR'
              '&authToken=${store.state.authToken}'
              '&deviceId=${store.state.deviceId}'
              '&externUserId=${store.state.externUserId}';

          if (triple.event == TripleEvent.error) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      physics: const BouncingScrollPhysics(),
                      child: RequestErrorWidget(
                        error: triple.error,
                        onPressed: () => store.authenticate(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (triple.state.authToken != null)
                  WebView(
                    initialUrl: url,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                    onProgress: (int progress) {
                      log('WebView is loading (progress : $progress%)');
                    },
                    javascriptChannels: <JavascriptChannel>{
                      _toasterJavascriptChannel(_),
                    }.toSet(),
                    navigationDelegate: (NavigationRequest request) async {
                      if (request.url == url) {
                        return NavigationDecision.navigate;
                      }
                      if (await canLaunch(request.url)) {
                        await launch(request.url);
                      } else {
                        Helpers.showDialog(
                          context,
                          RequestErrorWidget(
                            message: MediktorLabels.mediktorDiagnosisError,
                            buttonText: MediktorLabels.close,
                            onPressed: () => Modular.to.pop(),
                          ),
                          showClose: true,
                        );
                      }
                      return NavigationDecision.prevent;
                    },
                    onPageStarted: (String url) {
                      log('Page started loading: $url');
                    },
                    onPageFinished: (String url) {
                      log('Page finished loading: $url');
                    },
                    gestureNavigationEnabled: true,
                  ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar:
          TripleBuilder<MediktorDiagnosisStore, DioError, TokenMediktorModel>(
        store: store,
        builder: (_, triple) {
          if (store.isLoading) {
            return const SizedBox();
          } else {
            return BottomButtonWidget(
              isDisabled: store.state.isSessionFinished!,
              onPressed: () async {
                if (_buttonText == 'Continuar') {
                  if (recomendationStore.state.diagnosis!.urgency!.toJson! >=
                      3) {
                    await recomendationStore
                        .sendHighUrgencyDiagnosis()
                        .catchError((onError) {
                      Helpers.showDialog(
                        context,
                        RequestErrorWidget(
                          error: onError,
                          buttonText: MediktorLabels.close,
                          onPressed: () => Modular.to.pop(),
                        ),
                      );
                    });
                  }
                  Modular.to.pushReplacementNamed(
                    '/home/mediktor/diagnosis/mediktorRecomendationDiagnosisPage',
                    arguments: recomendationStore.state,
                  );
                } else {
                  Modular.to.pop();
                }
              },
              text: _buttonText,
            );
          }
        },
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: MediktorLabels.mediktorDiagnosisName,
      onMessageReceived: (JavascriptMessage events) {
        log(events.message);
        if (events.message.contains('component.loaded')) {
          store.setLoading(false);
        }
        if (events.message.contains('sessionFinish')) {
          recomendationStore
              .update(RecomendationModel.fromJson(events.message));

          if (recomendationStore.state.diagnosis!.sessionConclusions!
                  .summarySessionConclusionList !=
              null) {
            store.state.isSessionFinished = false;
            store.onFinishSessionEnableButton(store.state);
          } else {
            _buttonText = MediktorLabels.close;
            store.state.isSessionFinished = false;
            store.onFinishSessionEnableButton(store.state);
          }
        }
      },
    );
  }
}
