import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/urgency_teleattendance/teleattendance_store.dart';
import 'package:omni_core/src/app/shared/widgets/rating_dialog/rating_dialog.dart';
import 'package:omni_general/omni_general.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TeleattendancePage extends StatefulWidget {
  final String? moduleName;
  const TeleattendancePage({Key? key, required this.moduleName})
      : super(key: key);

  @override
  State<TeleattendancePage> createState() => _TeleattendancePageState();
}

class _TeleattendancePageState extends State<TeleattendancePage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final TeleattendanceStore store = TeleattendanceStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.moduleName!).build(context) as AppBar,
      extendBodyBehindAppBar: true,
      body: TripleBuilder<TeleattendanceStore, DioError, bool>(
        store: store,
        builder: (_, triple) {
          if (triple.isLoading) {
            return const LoadingWidget();
          }
          if (triple.event == TripleEvent.error) {
            return Center(
              child: SingleChildScrollView(
                clipBehavior: Clip.antiAlias,
                physics: const BouncingScrollPhysics(),
                child: RequestErrorWidget(
                  message: triple.error!.response!.data['error'].toString(),
                  buttonText: 'Fechar',
                  // onPressed: () async {
                  //   await store.getPharmaOrganizationsList(
                  //     categoryId: widget.categoryParam,
                  //   );
                  // },
                ),
              ),
            );
          }
          return SafeArea(
            child: SizedBox(
              child: WebView(
                initialUrl: store.webViewUrl,
                zoomEnabled: false,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                onProgress: (int progress) {
                  log('WebView is loading (progress : $progress%)');
                },
                javascriptChannels: <JavascriptChannel>{
                  // _toasterJavascriptChannel(_),
                }.toSet(),
                navigationDelegate: (NavigationRequest request) async {
                  if (request.url == store.webViewUrl) {
                    return NavigationDecision.navigate;
                  }
                  if (await canLaunchUrl(Uri.parse(request.url))) {
                    await launchUrl(Uri.parse(request.url));
                  } else {
                    // Helpers.showDialog(
                    //   context,
                    //   RequestErrorWidget(
                    //     // message: MediktorLabels.mediktorDiagnosisError,
                    //     // buttonText: MediktorLabels.close,
                    //     message: 'Error',
                    //     buttonText: 'Fechar',
                    //     onPressed: () => Modular.to.pop(),
                    //   ),
                    // );
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
            ),
          );
        },
      ),
    );
  }
}
