import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/core/enums/medicine_status_enum.dart';
import 'package:omni_drug_control/src/core/models/consuption_model.dart';
import 'package:omni_drug_control/src/core/models/medicine_model.dart';
import 'package:omni_drug_control/src/drug_control_historic/pages/widgets/drug_control_date_filter_widget.dart';
import 'package:omni_drug_control/src/drug_control_historic/pages/widgets/drugcontrol_vertical_timeline_item_widget.dart';
import 'package:omni_drug_control/src/drug_control_historic/pages/widgets/historic_item_shimmer_widget.dart';
import 'package:omni_drug_control/src/drug_control_historic/pages/widgets/new_drug_control_date_filter_widget.dart';
import 'package:omni_drug_control/src/drug_control_historic/stores/consuption_store.dart';
import 'package:omni_drug_control/src/drug_control_historic/stores/drug_control_historic_store.dart';
import 'package:omni_drug_control/src/drug_control_historic/stores/medicine_historic_store.dart';
import 'package:omni_drug_control_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class MedicineHistoricPage extends StatefulWidget {
  const MedicineHistoricPage({Key? key}) : super(key: key);

  @override
  _MedicineHistoricPageState createState() => _MedicineHistoricPageState();
}

class _MedicineHistoricPageState extends State<MedicineHistoricPage> {
  final MedicineHistoricStore store = Modular.get();
  final DrugControlHistoricStore drugControlStore = Modular.get();
  final ConsuptionStore consuptionStore = Modular.get();
  final ScrollController scrollController = ScrollController();
  final DatePickerController dateController = DatePickerController();
  bool isMandatory = false;

  final TextEditingController justificationController = TextEditingController(
    text: '',
  );

  @override
  void initState() {
    final DateTime now = DateTime.now();
    store.params.startDate = Formaters.dateToStringDate(
      DateTime(now.year, now.month),
    );
    store.params.endDate = Formaters.dateToStringDate(
      DateTime(now.year, now.month + 1, 0),
    );
    store.getDrugControlsDays(store.params, now).then((day) {
      dateController.animateToDate(
        DateTime(now.year, now.month, day!),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.decelerate,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          DrugControlDateFilterWidget(dateController: dateController),
          const Divider(),
          Expanded(
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
                  store.getMedicines(store.params);
                },
                child: _buildMedicineListWidget,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildMedicineListWidget {
    return TripleBuilder<MedicineHistoricStore, DioError, List<DateTime>>(
      store: store,
      builder: (_, triple) {
        Widget loading = const SizedBox();
        if (triple.isLoading) {
          loading = const HistoricItemShimmerWidget();
        }

        if (triple.event == TripleEvent.error) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: RequestErrorWidget(
                      error: triple.error,
                      onPressed: () => store.getMedicines(store.params),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        return Stack(
          children: [
            if (store.medicines.results!.isEmpty && !triple.isLoading)
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        clipBehavior: Clip.antiAlias,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        physics: const BouncingScrollPhysics(),
                        child: EmptyWidget(
                          message: DrugControlLabels.medicineHistoricEmptyList,
                          textButton: DrugControlLabels.tryAgain,
                          onPressed: () => store.getMedicines(store.params),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (store.medicines.results!.isNotEmpty)
              Scrollbar(
                controller: scrollController,
                child: ListView.builder(
                  itemCount: store.medicines.results!.length,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: store.medicines.results![index].status!.label != 'Não Consumido' &&
                              store.medicines.results![index].status!.label != 'Consumido'
                          ? () async {
                              consuptionStore.state.confirmMedicineConsupution = false;
                              consuptionStore.state.confirmMedicineNotConsupution = false;
                              consuptionStore.updateForm(consuptionStore.state);

                              showModalBottomSheet(
                                backgroundColor: Colors.white,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: _buildInformConsuptionMedicine(
                                      store.medicines.results![index],
                                    ),
                                  );
                                },
                              );
                            }
                          : null,
                      child: SafeArea(
                        bottom: store.medicines.results!.last == store.medicines.results![index],
                        child: DrugControlVerticalTimelineItemWidget(
                          medicine: store.medicines.results![index],
                          index: index,
                          child: _buildMedicineItemWidget(
                            store.medicines.results![index],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            loading,
          ],
        );
      },
    );
  }

  Widget _buildMedicineItemWidget(MedicineModel medicine) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  _statusMedicine(medicine.status!),
                  const Spacer(),
                  Icon(
                    Icons.access_time,
                    size: 20,
                    color: Theme.of(context).cardColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    Formaters.dateToStringTime(
                      Formaters.stringToDateTime(medicine.dataUso!),
                    ),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      '${medicine.medicamento!.medicine} ',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      overflow: medicine.medicamento!.medicine!.length < 20 ? null : TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  if (medicine.medicamento!.medicine!.length < 20) const Spacer(),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    Formaters.dateToStringDate(
                      Formaters.stringToDateTime(medicine.dataUso!),
                    ),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                '${medicine.medicamento?.dosage ?? '-'} '
                '${medicine.medicamento?.unity ?? '-'} '
                '${medicine.medicamento?.administration ?? '-'} ',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Visibility(
                visible: medicine.justificativa!.isNotEmpty,
                child: Text(
                  '${DrugControlLabels.medicineHistoricInformJustification}: ${medicine.justificativa ?? '-'} ',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statusMedicine(MedicineStatusTypeEnum status) {
    return Text(
      status.label,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: status.getColorStatusMedicine,
          ),
    );
  }

  Widget _buildInformConsuptionMedicine(MedicineModel medicine) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TripleBuilder<ConsuptionStore, DioError, ConsuptionModel>(
            store: consuptionStore,
            builder: (context, triple) {
              return Container(
                padding: const EdgeInsets.only(top: 10),
                margin: const EdgeInsets.only(
                  bottom: 25,
                  top: 25,
                  left: 15,
                  right: 15,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DrugControlLabels.medicineHistoricInformConsumption,
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: DefaultButtonWidget(
                            onPressed: () async {
                              consuptionStore.state.confirmMedicineConsupution = true;
                              consuptionStore.state.confirmMedicineNotConsupution = false;
                              consuptionStore.state.consumed = true;
                              consuptionStore.updateForm(consuptionStore.state);
                            },
                            text: DrugControlLabels.medicineHistoricInformDrank,
                            buttonType: consuptionStore.state.confirmMedicineConsupution!
                                ? DefaultButtonType.primary
                                : DefaultButtonType.outline,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: DefaultButtonWidget(
                            onPressed: () async {
                              consuptionStore.state.confirmMedicineConsupution = false;
                              consuptionStore.state.confirmMedicineNotConsupution = true;
                              consuptionStore.state.consumed = false;
                              consuptionStore.updateForm(consuptionStore.state);
                            },
                            text: DrugControlLabels.medicineHistoricInformNotDrank,
                            buttonType: consuptionStore.state.confirmMedicineNotConsupution!
                                ? DefaultButtonType.primary
                                : DefaultButtonType.outline,
                          ),
                        ),
                      ],
                    ),
                    if ((DateTime.now().difference(
                                  Formaters.stringToDate(medicine.dataUso!),
                                ) <
                                Duration.zero &&
                            consuptionStore.state.confirmMedicineConsupution!) ||
                        consuptionStore.state.confirmMedicineNotConsupution!)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldWidget(
                            label: DrugControlLabels.medicineHistoricInformJustification,
                            controller: justificationController,
                            validator: (value) {
                              if ((DateTime.now().difference(
                                            Formaters.stringToDate(
                                              medicine.dataUso!,
                                            ),
                                          ) <
                                          Duration.zero &&
                                      consuptionStore.state.confirmMedicineConsupution!) ||
                                  consuptionStore.state.confirmMedicineNotConsupution!) {
                                return DrugControlLabels.medicineHistoricInformRequiredField;
                              } else {
                                return null;
                              }
                            },
                            onChange: (value) {
                              consuptionStore.state.justification = value;
                              consuptionStore.updateForm(consuptionStore.state);
                            },
                          ),
                          if (isMandatory)
                            Text(
                              DrugControlLabels.medicineHistoricInformRequiredField,
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.red,
                                  ),
                            )
                          else
                            Container(),
                        ],
                      )
                    else
                      Container(),
                  ],
                ),
              );
            },
          ),
          TripleBuilder(
            store: consuptionStore,
            builder: (_, triple) {
              return BottomButtonWidget(
                isLoading: triple.isLoading,
                isDisabled: triple.isLoading,
                onPressed: () {
                  if ((DateTime.now().difference(
                                Formaters.stringToDate(
                                  medicine.dataUso!,
                                ),
                              ) <
                              Duration.zero &&
                          consuptionStore.state.confirmMedicineConsupution! &&
                          justificationController.text.isEmpty) ||
                      consuptionStore.state.confirmMedicineNotConsupution! && justificationController.text.isEmpty) {
                    isMandatory = true;
                    consuptionStore.updateForm(consuptionStore.state);
                  } else {
                    isMandatory = false;
                    consuptionStore.state.justification ??= '';
                    consuptionStore
                        .informConsumption(
                      consuptionStore.state,
                      medicine.id!,
                    )
                        .then((value) async {
                      consuptionStore.updateForm(ConsuptionModel());
                      justificationController.clear();
                      Modular.to.pop();
                      await store.getMedicines(store.params);
                    }).catchError((onError) {
                      Modular.to.pop();
                      Helpers.showDialog(
                        context,
                        RequestErrorWidget(
                          error: onError,
                          buttonText: DrugControlLabels.close,
                          onPressed: () {
                            Modular.to.pop();
                          },
                        ),
                      );
                    });
                  }
                },
                text: DrugControlLabels.send,
              );
            },
          ),
        ],
      ),
    );
  }
}
