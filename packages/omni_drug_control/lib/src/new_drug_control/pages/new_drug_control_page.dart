import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/drug_control_historic/stores/drug_control_historic_store.dart';
import 'package:omni_drug_control/src/new_drug_control/pages/new_drug_control_success_page.dart';
import 'package:omni_drug_control/src/new_drug_control/pages/widgets/new_drug_control_caregiver_widget.dart';
import 'package:omni_drug_control/src/new_drug_control/pages/widgets/new_drug_control_how_use_widget.dart';
import 'package:omni_drug_control/src/new_drug_control/pages/widgets/new_drug_control_medicines_widget.dart';
import 'package:omni_drug_control/src/new_drug_control/pages/widgets/new_drug_control_observation_widget.dart';
import 'package:omni_drug_control/src/new_drug_control/pages/widgets/new_drug_control_program_disease_widget.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_store.dart';
import 'package:omni_drug_control_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class NewDrugControlPage extends StatefulWidget {
  final String moduleName;
  final ProgramModel program;
  final bool useCustomMedication;
  final bool useCaregiver;

  const NewDrugControlPage({
    Key? key,
    required this.moduleName,
    required this.program,
    required this.useCustomMedication,
    required this.useCaregiver,
  }) : super(key: key);

  @override
  _NewDrugControlPageState createState() => _NewDrugControlPageState();
}

class _NewDrugControlPageState extends State<NewDrugControlPage> {
  final NewDrugControlStore store = Modular.get();
  final DrugControlHistoricStore historicStore = Modular.get();
  final TextEditingController drugController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    drugController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(
        title: widget.moduleName,
      ).build(context) as AppBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(15),
              controller: scrollController,
              child: TripleBuilder(
                store: store,
                builder: (_, triple) {
                  return Opacity(
                    opacity: triple.isLoading ? 0.5 : 1.0,
                    child: AbsorbPointer(
                      absorbing: triple.isLoading,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          NewDrugControlMedicinesWidget(
                            useCustomMedication: widget.useCustomMedication,
                          ),
                          const SizedBox(height: 15),
                          NewDrugControlProgramDiseaseWidget(
                            program: widget.program,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            DrugControlLabels.newDrugControlHowToDrank,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 15),
                          NewDrugControlHowUseWidget(
                            useCustomMedication: widget.useCustomMedication,
                          ),
                          const SizedBox(height: 15),
                          NewDrugControlObservationWidget(
                            useCustomMedication: widget.useCustomMedication,
                          ),
                          if (widget.useCaregiver) const SizedBox(height: 15),
                          if (widget.useCaregiver)
                            NewDrugControlCaregiverWidget(
                              scrollController: scrollController,
                              moduleName: widget.moduleName,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const NewDrugControlSuccess(),
          ],
        ),
      ),
      bottomNavigationBar: TripleBuilder(
        store: store,
        builder: (_, triple) {
          return BottomButtonWidget(
            onPressed: () {
              if (store.pageSelected == 0) {
                scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                );
                store.createDrugControl(store.state).then((value) {
                  store.pageSelected = 1;
                  store.updateForm(store.state);
                  historicStore.getDrugControls(historicStore.params);
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.decelerate,
                  );
                }).catchError((onError) {
                  Helpers.showDialog(
                    context,
                    RequestErrorWidget(
                      error: onError,
                      buttonText: DrugControlLabels.close,
                      onPressed: () => Modular.to.pop(),
                    ),
                    showClose: true,
                  );
                });
              } else {
                Modular.to.pushReplacementNamed(
                  '../drugControlDetails',
                  arguments: store.state,
                );
              }
            },
            isLoading: triple.isLoading,
            isDisabled: store.isDisable(),
            buttonType: BottomButtonType.outline,
            text: store.pageSelected == 0
                ? DrugControlLabels.newDrugControlAddMedicine
                : DrugControlLabels.newDrugControlSeeMedicine,
          );
        },
      ),
    );
  }
}
