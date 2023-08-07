import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/core/constants/drug_control_interval.dart';
import 'package:omni_drug_control/src/core/enums/drug_control_enum.dart';
import 'package:omni_drug_control/src/core/models/drug_control_model.dart';
import 'package:omni_drug_control/src/drug_control_details/drug_control_details_store.dart';
import 'package:omni_drug_control_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class DrugControlDetailsPage extends StatefulWidget {
  final DrugControlModel drugControl;
  const DrugControlDetailsPage({Key? key, required this.drugControl})
      : super(key: key);

  @override
  _DrugControlDetailsPageState createState() => _DrugControlDetailsPageState();
}

class _DrugControlDetailsPageState extends State<DrugControlDetailsPage> {
  final DrugControlDetailsStore store = Modular.get();
  @override
  void initState() {
    store.getDrugControlById(widget.drugControl.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: DrugControlLabels.drugControlDetailsTitle,
      ).build(context) as AppBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Theme(
          data: Theme.of(context).copyWith(
            shadowColor: Colors.transparent,
          ),
          child: RefreshIndicator(
            displacement: 0,
            strokeWidth: 0.75,
            color: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context).colorScheme.background,
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async {
              store.getDrugControlById(widget.drugControl.id!);
            },
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: _buildDetailsFormWidget,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.red),
        child: BottomButtonWidget(
          onPressed: () {
            Helpers.showDialog(
              context,
              _buildRemoveDrugControlWidget,
            );
          },
          buttonType: BottomButtonType.outline,
          text: DrugControlLabels.drugControlDetailsRemove,
        ),
      ),
    );
  }

  Widget get _buildRemoveDrugControlWidget {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Text(
            '${DrugControlLabels.drugControlDetailsWantRemove} '
            '${widget.drugControl.medicine}?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: DefaultButtonWidget(
                  onPressed: () => Navigator.pop(context),
                  text: DrugControlLabels.cancel,
                  buttonType: DefaultButtonType.outline,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(primaryColor: Colors.red),
                  child: DefaultButtonWidget(
                    onPressed: () {
                      Modular.to.pop();
                      store
                          .removeDrugControlById(
                        widget.drugControl.id.toString(),
                      )
                          .then((value) async {
                        await Helpers.showDialog(
                          context,
                          SuccessWidget(
                            message: DrugControlLabels
                                .drugControlDetailsRemovesuccess,
                            onPressed: () {
                              Modular.to.pop();
                            },
                          ),
                        );
                        Modular.to.pop();
                      }).catchError(
                        (onError) {
                          Helpers.showDialog(
                            context,
                            RequestErrorWidget(
                              message: onError.toString(),
                              onPressed: () {
                                Modular.to.pop();
                              },
                              buttonText: DrugControlLabels.close,
                            ),
                          );
                        },
                      );
                    },
                    text: DrugControlLabels.remove,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget get _buildDetailsFormWidget {
    return TripleBuilder<DrugControlDetailsStore, DioError, DrugControlModel>(
      store: store,
      builder: (_, triple) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RowTextFieldWidget(
              label: DrugControlLabels.drugControlDetailsMedicineLabel,
              value: triple.state.medicine,
              isLoading: triple.isLoading,
            ),
            RowTextFieldWidget(
              label: DrugControlLabels.drugControlDetailsTypeLabel,
              value: triple.state.type?.label,
              isLoading: triple.isLoading,
            ),
            RowTextFieldWidget(
              label: DrugControlLabels.drugControlDetailsIntervalLabel,
              value: DRUG_CONTROL_INTERVALS[triple.state.interval],
              isLoading: triple.isLoading,
            ),
            RowTextFieldWidget(
              label: DrugControlLabels.drugControlDetailsDosageLabel,
              value: triple.state.dosage,
              isLoading: triple.isLoading,
            ),
            RowTextFieldWidget(
              label: DrugControlLabels.drugControlDetailsUnityLabel,
              value: triple.state.unity,
              isLoading: triple.isLoading,
            ),
            RowTextFieldWidget(
              label: DrugControlLabels.drugControlDetailsAdministrationLabel,
              value: triple.state.administration,
              isLoading: triple.isLoading,
            ),
            RowTextFieldWidget(
              label: DrugControlLabels.drugControlDetailsStartDateLabel,
              value: triple.state.startDate != null
                  ? Formaters.dateToStringDate(
                      Formaters.stringToDate(
                        triple.state.startDate!,
                      ),
                    )
                  : null,
              isLoading: triple.isLoading,
            ),
            if (triple.state.continuousUse)
              RowTextFieldWidget(
                label: DrugControlLabels.drugControlDetailsContinuosUseLabel,
                value: DrugControlLabels.drugControlDetailsContinuosUseValue,
                isLoading: triple.isLoading,
              ),
            if (!triple.state.continuousUse)
              RowTextFieldWidget(
                label: DrugControlLabels.drugControlDetailsEndDateLabel,
                value: triple.state.endDate != null
                    ? Formaters.dateToStringDate(
                        Formaters.stringToDate(
                          triple.state.endDate!,
                        ),
                      )
                    : null,
                isLoading: triple.isLoading,
              ),
            RowTextFieldWidget(
              label: DrugControlLabels.drugControlDetailsDescriptionLabel,
              value: triple.state.description,
              isLoading: triple.isLoading,
            ),
            if (triple.state.caregivers.isNotEmpty) const SizedBox(height: 25),
            if (triple.state.caregivers.isNotEmpty)
              Text(
                DrugControlLabels.drugControlDetailsCaregiverData,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            if (triple.state.caregivers.isNotEmpty) const SizedBox(height: 5),
            Column(
              children: triple.state.caregivers
                  .map(
                    (caregiver) => RowTextFieldWidget(
                      label: DrugControlLabels
                          .drugControlDetailsCaregiverNameLabel,
                      value: caregiver.name,
                      isLoading: triple.isLoading,
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
