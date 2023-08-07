import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_dosage_store.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_store.dart';
import 'package:omni_drug_control_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class NewDrugControlDosageWidget extends StatefulWidget {
  final bool useCustomMedication;

  const NewDrugControlDosageWidget({
    Key? key,
    required this.useCustomMedication,
  }) : super(key: key);

  @override
  _NewDrugControlDosageWidgetState createState() =>
      _NewDrugControlDosageWidgetState();
}

class _NewDrugControlDosageWidgetState
    extends State<NewDrugControlDosageWidget> {
  final NewDrugControlDosageStore store = Modular.get();
  final NewDrugControlStore drugControlStore = Modular.get();
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    if (widget.useCustomMedication) {
      store.getDosages();
    }
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<NewDrugControlDosageStore, DioError,
        List<KeyValueModel>>(
      store: store,
      builder: (_, triple) {
        if (!widget.useCustomMedication) {
          return TextFieldWidget(
            label: DrugControlLabels.newDrugControlDosageLabel,
            placeholder: DrugControlLabels.newDrugControlDosagePlaceholder,
            controller: textController,
            onChange: (String? input) {
              drugControlStore.state.dosage = input;
              drugControlStore.update(drugControlStore.state);
            },
          );
        }
        return GestureDetector(
          onTap: () {
            store.getDosages();
          },
          child: SelectFieldWidget<KeyValueModel>(
            label: DrugControlLabels.newDrugControlDosageLabel,
            items: triple.state,
            isLoading: triple.isLoading,
            placeholder: DrugControlLabels.newDrugControlDosagePlaceholder,
            controller: textController,
            onSelectItem: (KeyValueModel dosage) {
              textController.text = dosage.value!;
              drugControlStore.state.dosage = dosage.value;
              drugControlStore.update(drugControlStore.state);
            },
            itemsLabels: triple.state.map((observation) {
              return observation.value!;
            }).toList(),
            isEnabled: triple.event != TripleEvent.error &&
                (triple.state.isNotEmpty && !triple.isLoading),
            errorText: triple.event == TripleEvent.error
                ? DrugControlLabels.newDrugControlGeneralError
                : triple.state.isEmpty && !triple.isLoading
                    ? DrugControlLabels.newDrugControlEmptyError
                    : null,
          ),
        );
      },
    );
  }
}
