import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_observation_store.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_store.dart';
import 'package:omni_drug_control_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class NewDrugControlObservationWidget extends StatefulWidget {
  final bool useCustomMedication;

  const NewDrugControlObservationWidget({
    Key? key,
    required this.useCustomMedication,
  }) : super(key: key);

  @override
  _NewDrugControlObservationWidgetState createState() =>
      _NewDrugControlObservationWidgetState();
}

class _NewDrugControlObservationWidgetState
    extends State<NewDrugControlObservationWidget> {
  final NewDrugControlObservationStore store = Modular.get();
  final NewDrugControlStore drugControlStore = Modular.get();
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    if (widget.useCustomMedication) {
      store.getObservations();
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
    return TripleBuilder<NewDrugControlObservationStore, DioError,
        List<KeyValueModel>>(
      store: store,
      builder: (_, triple) {
        if (!widget.useCustomMedication) {
          return TextFieldWidget(
            label: DrugControlLabels.newDrugControlObservationLabel,
            placeholder: DrugControlLabels.newDrugControlObservationPlaceholder,
            controller: textController,
            onChange: (String? input) {
              drugControlStore.state.description = input;
              drugControlStore.update(drugControlStore.state);
            },
          );
        }
        return GestureDetector(
          onTap: () {
            store.getObservations();
          },
          child: SelectFieldWidget<KeyValueModel>(
            label: DrugControlLabels.newDrugControlObservationLabel,
            items: triple.state,
            itemsLabels: triple.state.map((observation) {
              return observation.value!;
            }).toList(),
            isLoading: triple.isLoading,
            placeholder: DrugControlLabels.newDrugControlObservationPlaceholder,
            controller: textController,
            onSelectItem: (KeyValueModel observation) {
              textController.text = observation.value!;
              drugControlStore.state.description = observation.value;
              drugControlStore.update(drugControlStore.state);
            },
            isEnabled: triple.event != TripleEvent.error &&
                (triple.state.isNotEmpty && !triple.isLoading),
            errorText: triple.event == TripleEvent.error
                ? DrugControlLabels.newDrugControlGeneralError
                : triple.state.isEmpty && !triple.isLoading
                    ? DrugControlLabels.newDrugControlObservationEmptyError
                    : null,
          ),
        );
      },
    );
  }
}
