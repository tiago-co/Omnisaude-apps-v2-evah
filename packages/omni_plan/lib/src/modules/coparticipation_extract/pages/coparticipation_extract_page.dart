import 'package:coparticipation_extract_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/extract_beneficiary_model.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/pages/widget/date_text_box_widget.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/stores/coparticipation_extract_store.dart';

class CoparticipationExtractPage extends StatefulWidget {
  const CoparticipationExtractPage({
    Key? key,
  }) : super(key: key);
  @override
  CoparticipationExtractPageState createState() =>
      CoparticipationExtractPageState();
}

class CoparticipationExtractPageState
    extends State<CoparticipationExtractPage> {
  CoparticipationExtractStore store = Modular.get();
  @override
  void initState() {
    store.initialDateTime = null;
    store.finalDateTime = null;
    store.updateState();
    super.initState();
  }

  Future<void> updateInitialDateTime(DateTime date) async {
    store.initialDateTime = date;
    store.updateState();
  }

  Future<void> updateFinalDateTime(DateTime date) async {
    store.finalDateTime = date;
    store.updateState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: Labels.coparticipationExtractTitle,
      ).build(context) as AppBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TripleBuilder<CoparticipationExtractStore, Exception,
              ExtractBeneficiaryModel>(
            store: store,
            builder: (_, triple) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(
                    parent: NeverScrollableScrollPhysics(),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          SvgPicture.asset(
                            Assets.coparticipationExtractWevertonBase,
                            package: AssetsPackage.omniCore,
                            width: 200,
                          ),
                          SvgPicture.asset(
                            Assets.coparticipationExtractWevertonColor,
                            package: AssetsPackage.omniCore,
                            color: Theme.of(context).primaryColor,
                            width: 200,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        Labels.coparticipationExtractSelectPeriod,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Labels.coparticipationExtractStartDateLabel,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 10),
                          DateTextBoxWidget(
                            initialValue: null,
                            hintText: Labels
                                .coparticipationExtractStartDatePlaceholder,
                            fontSize: 14,
                            color: Theme.of(context).cardColor,
                            onDateChange: updateInitialDateTime,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Labels.coparticipationExtractEndDateLabel,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 10),
                          DateTextBoxWidget(
                            initialValue: null,
                            hintText:
                                Labels.coparticipationExtractEndDatePlaceholder,
                            fontSize: 14,
                            color: Theme.of(context).cardColor,
                            onDateChange: updateFinalDateTime,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
      bottomNavigationBar: TripleBuilder<CoparticipationExtractStore, Exception,
          ExtractBeneficiaryModel>(
        store: store,
        builder: (_, triplo) {
          if (triplo.error != null) {
            Helpers.showDialog(
              context,
              RequestErrorWidget(
                onPressed: () async {
                  await store.getExtractBeneficiary();
                },
              ),
              showClose: true,
            );
          }
          return BottomButtonWidget(
            onPressed: () async {
              await store.getExtractBeneficiary().then(
                (value) {
                  Modular.to.pushReplacementNamed('period_extract');
                },
              ).catchError(
                (onError) {
                  Helpers.showDialog(
                    context,
                    onError,
                    showClose: true,
                  );
                },
              );
            },
            isDisabled:
                store.initialDateTime == null || store.finalDateTime == null,
            isLoading: store.isLoading,
            text: Labels.coparticipationExtractContinue,
          );
        },
      ),
    );
  }
}
