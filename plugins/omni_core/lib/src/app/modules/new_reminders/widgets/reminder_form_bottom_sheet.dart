import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/drug_control_historic_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_medicine_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/widgets/medicine_search_widget.dart';
import 'package:omni_core/src/app/modules/new_reminders/widgets/new_drug_control_dosage_widget.dart';
import 'package:omni_core/src/app/modules/new_reminders/widgets/new_drug_control_unity_widget.dart';
import 'package:omni_core/src/app/modules/new_reminders/widgets/select_time_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_general/src/widgets/dialog/birth_date_dialog.dart';

class ReminderFormBottomSheet extends StatefulWidget {
  ReminderFormBottomSheet({Key? key}) : super(key: key);

  @override
  State<ReminderFormBottomSheet> createState() => _ReminderFormBottomSheetState();
}

class _ReminderFormBottomSheetState extends State<ReminderFormBottomSheet> {
  final NewDrugControlStore store = Modular.get();

  final DrugControlHistoricStore historicStore = Modular.get();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController hourController = TextEditingController();
  final TextEditingController observationController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
            width: double.maxFinite,
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: TripleBuilder(
              store: store,
              builder: (context, triple) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Adicionar novo lembrete',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const MedicineSearchWidget(useCustomMedication: false),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldWidget(
                            label: 'Data de Inicio',
                            controller: dateController,
                            focusedborder: InputBorder.none,
                            padding: EdgeInsets.zero,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => const BirthDateDialog(),
                              ).then(
                                (date) {
                                  if (date == null) return;

                                  dateController.text = Formaters.dateToStringDate(date);
                                  store.state.startDate = date.toIso8601String();

                                  store.updateForm(store.state);
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: SelectTimeWidget(controller: hourController),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFieldWidget(
                      label: 'Período de tratamento',
                      controller: TextEditingController(),
                      focusedborder: InputBorder.none,
                      padding: EdgeInsets.zero,
                      suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: NewDrugControlDosageWidget(
                            useCustomMedication: false,
                          ),
                        ),
                        Expanded(
                          child: NewDrugControlUnityWidget(useCustomMedication: false),
                          // TextFieldWidget(
                          //   label: 'Medida',
                          //   controller: TextEditingController(),
                          //   focusedborder: InputBorder.none,
                          //   padding: EdgeInsets.zero,
                          //   suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                          // ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFieldWidget(
                      label: 'Observação',
                      controller: observationController,
                      focusedborder: InputBorder.none,
                      padding: EdgeInsets.zero,
                      onChange: (String? input) {
                        store.state.description = input;
                        store.updateForm(store.state);
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Deletar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff2D73B3),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 38,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffED8282),
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: TextButton(
                            onPressed: () {
                              store.state.continuousUse = true;
                              store.state.administration = 'Oral';
                              store.state.interval = '1-/-d';
                              store.createDrugControl(store.state).then((value) {
                                store.updateForm(store.state);
                                historicStore.getDrugControls(historicStore.params);
                              }).catchError((onError) {
                                Helpers.showDialog(
                                  context,
                                  RequestErrorWidget(
                                    error: onError,
                                    buttonText: 'Fechar',
                                    onPressed: () => Modular.to.pop(),
                                  ),
                                  showClose: true,
                                );
                              });
                            },
                            child: const Text(
                              'Salvar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 1.7142857143,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            )),
      ],
    );
  }
}
