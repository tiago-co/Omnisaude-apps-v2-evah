import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:html/parser.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_mediktor/src/core/models/mediktor_diagnosis_model.dart';
import 'package:omni_mediktor/src/core/models/session_conclusion_object_model.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis_details/mediktor_diagnosis_details_store.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis_details/widgets/mediktor_details_card_widget.dart';
import 'package:omni_mediktor/src/mediktor_historic/widgets/mediktor_urgency_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MediktorDiagnosisDetailsPage extends StatefulWidget {
  final String sessionId;
  const MediktorDiagnosisDetailsPage({
    Key? key,
    required this.sessionId,
  }) : super(key: key);

  @override
  _MediktorDiagnosisStateDetailsPage createState() =>
      _MediktorDiagnosisStateDetailsPage();
}

class _MediktorDiagnosisStateDetailsPage
    extends State<MediktorDiagnosisDetailsPage> {
  final MediktorDiagnosisDetailsStore store = Modular.get();
  final Completer<WebViewController> webViewController =
      Completer<WebViewController>();

  int index = 0;

  @override
  void initState() {
    store.getDiagnosisDetails(widget.sessionId);
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: 'Detalhes do diagnóstico',
      ).build(context) as AppBar,
      resizeToAvoidBottomInset: true,
      body: TripleBuilder<MediktorDiagnosisDetailsStore, Exception,
          MediktorDiagnosisModel>(
        store: store,
        builder: (_, triple) {
          if (triple.isLoading) {
            return const LoadingWidget();
          }

          if (triple.event == TripleEvent.error) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      physics: const BouncingScrollPhysics(),
                      child: RequestErrorWidget(
                        onPressed: () =>
                            store.mediktorDiagnosisStore.authenticate(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _conclusionDiagnosisMessageWidget,
                    const SizedBox(height: 25),
                    if (store.state.sessionConclusions!
                            .summarySessionConclusionList !=
                        null)
                      _conclusionDiagnosisDeceasesWidget,
                    Divider(
                      color: Theme.of(context).cardColor,
                    ),
                    const SizedBox(height: 25),
                    _conclusionDiagnosisUrgencyWidget,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get _conclusionDiagnosisMessageWidget {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.info_outline,
              size: 15,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Recomendação',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.yellow.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: SvgPicture.asset(
                  Assets.alertMediktor,
                  height: 50,
                  width: 50,
                  package: AssetsPackage.omniMediktor,
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  parseFragment(store.state.summarySessionRecommendation)
                      .text!
                      .replaceAll('\n', '')
                      .replaceAll('   ', ''),
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.orange[800],
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget get _conclusionDiagnosisDeceasesWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Doenças *',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 5),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, index) {
            return Divider(
              color: Theme.of(context).cardColor.withOpacity(0.25),
            );
          },
          shrinkWrap: true,
          itemCount: store
              .state.sessionConclusions!.summarySessionConclusionList!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    this.index = index;
                    return _buildSpecialtySheetWidget(
                      context,
                      store.state.sessionConclusions!
                          .summarySessionConclusionList![this.index],
                    );
                  },
                );
              },
              child: MediktorDetailsCardWidget(
                diagnosis: store.state.sessionConclusions!
                    .summarySessionConclusionList![index],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget get _conclusionDiagnosisUrgencyWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Urgência',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 5),
        MediktorUrgencyWidget(urgency: store.state.urgency!),
      ],
    );
  }

  Widget _buildSpecialtySheetWidget(
    BuildContext context,
    SessionConclusionObject specialty,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BottomSheetHeaderWidget(
                title: 'Especialidade',
              ),
              Flexible(child: _buildSpecialtyListWidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialtyListWidget() {
    return TripleBuilder(
      store: store,
      builder: (_, triple) {
        if (triple.event == TripleEvent.error) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Flexible(
                child: SingleChildScrollView(
                  clipBehavior: Clip.antiAlias,
                  physics: BouncingScrollPhysics(),
                  child: RequestErrorWidget(),
                ),
              ),
            ],
          );
        }
        if (store
            .state.sessionConclusions!.summarySessionConclusionList!.isEmpty) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!triple.isLoading) const SizedBox(height: 2.5),
              if (triple.isLoading)
                LinearProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  minHeight: 2.5,
                ),
              const SizedBox(height: 15),
              const EmptyWidget(
                message: 'Nenhuma especialidade encontrada!',
              ),
            ],
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!triple.isLoading) const SizedBox(height: 2.5),
            if (triple.isLoading)
              LinearProgressIndicator(
                color: Theme.of(context).primaryColor,
                minHeight: 2.5,
              ),
            Flexible(
              child: ListView.builder(
                itemCount: store.state.sessionConclusions!
                    .summarySessionConclusionList![index].specialties!.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return _buildSpecialtyItemWidget(
                    store
                        .state
                        .sessionConclusions!
                        .summarySessionConclusionList![this.index]
                        .specialties![index],
                    store
                        .state
                        .sessionConclusions!
                        .summarySessionConclusionList![this.index]
                        .specialtiesId![index],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSpecialtyItemWidget(String specialty, String specialtyId) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        enableFeedback: true,
        onTap: () {
          Modular.to.pop();
          Modular.to.pushNamed(
            '/home/mediktor/diagnosis/mediktorRecomendationCardsPage',
            arguments: specialtyId,
          );
        },
        title: Container(
          constraints: const BoxConstraints(maxHeight: 50),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
              specialty,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minLeadingWidth: 0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.arrowRight,
              color: Theme.of(context).primaryColor,
              height: 10,
              width: 10,
              package: AssetsPackage.omniGeneral,
            ),
          ],
        ),
      ),
    );
  }
}
