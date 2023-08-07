import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_mediktor/src/core/models/recomendation_model.dart';
import 'package:omni_mediktor/src/core/models/session_conclusion_object_model.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/stores/mediktor_recomendation_store.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis_details/widgets/mediktor_details_card_widget.dart';
import 'package:omni_mediktor/src/mediktor_historic/widgets/mediktor_urgency_widget.dart';
import 'package:omni_mediktor_labels/labels.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MediktorRecomendationDiagnosisPage extends StatefulWidget {
  final RecomendationModel recomendationModel;
  const MediktorRecomendationDiagnosisPage({
    Key? key,
    required this.recomendationModel,
  }) : super(key: key);

  @override
  _MediktorDiagnosisStateDetailsPage createState() =>
      _MediktorDiagnosisStateDetailsPage();
}

class _MediktorDiagnosisStateDetailsPage
    extends State<MediktorRecomendationDiagnosisPage> {
  final MediktorRecomendationStore store =
      Modular.get<MediktorRecomendationStore>();
  int index = 0;

  @override
  void initState() {
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
        title: MediktorLabels.mediktorRecomendationDiagnosisTitle,
      ).build(context) as AppBar,
      resizeToAvoidBottomInset: true,
      body: TripleBuilder<MediktorRecomendationStore, DioError,
          RecomendationModel>(
        store: store,
        builder: (_, triple) {
          if (triple.isLoading) {
            return const LoadingWidget();
          }

          if (triple.event == TripleEvent.error) {
            return Column(
              children: const [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      physics: BouncingScrollPhysics(),
                      child: RequestErrorWidget(),
                    ),
                  ),
                ),
              ],
            );
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _conclusionDiagnosisDeceasesWidget,
                  const SizedBox(height: 25),
                  const SizedBox(height: 25),
                  Divider(
                    color: Theme.of(context).cardColor,
                  ),
                  const SizedBox(height: 25),
                  _conclusionDiagnosisUrgencyWidget,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get _conclusionDiagnosisDeceasesWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          MediktorLabels.mediktorRecomendationDiagnosisIllnesses,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 5),
        ListView.separated(
          physics: const ClampingScrollPhysics(),
          separatorBuilder: (_, index) {
            return Divider(
              color: Theme.of(context).cardColor.withOpacity(0.25),
            );
          },
          shrinkWrap: true,
          itemCount: widget.recomendationModel.diagnosis!.sessionConclusions!
              .summarySessionConclusionList!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                this.index = index;
                await showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    //ONTAp
                    return _buildSpecialtySheetWidget(
                      context,
                      widget.recomendationModel.diagnosis!.sessionConclusions!
                          .summarySessionConclusionList![this.index],
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Expanded(
                    child: MediktorDetailsCardWidget(
                      diagnosis: widget
                          .recomendationModel
                          .diagnosis!
                          .sessionConclusions!
                          .summarySessionConclusionList![index],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).primaryColor,
                    size: 16,
                  ),
                ],
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
          MediktorLabels.mediktorRecomendationDiagnosisUrgency,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 5),
        MediktorUrgencyWidget(
          urgency: widget.recomendationModel.diagnosis!.urgency!,
        ),
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
                title: MediktorLabels.mediktorRecomendationDiagnosisSpecialty,
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
        if (widget.recomendationModel.diagnosis!.sessionConclusions!
            .summarySessionConclusionList!.isEmpty) {
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
                message: MediktorLabels.mediktorRecomendationDiagnosisEmpty,
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
                itemCount: widget
                    .recomendationModel
                    .diagnosis!
                    .sessionConclusions!
                    .summarySessionConclusionList![index]
                    .specialties!
                    .length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return _buildSpecialtyItemWidget(
                    widget
                        .recomendationModel
                        .diagnosis!
                        .sessionConclusions!
                        .summarySessionConclusionList![this.index]
                        .specialties![index],
                    widget
                        .recomendationModel
                        .diagnosis!
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
