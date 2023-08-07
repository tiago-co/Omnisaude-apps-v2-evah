import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/core/constants/via_administration.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_administration_store.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_store.dart';
import 'package:omni_drug_control_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class NewDrugControlAdministrationWidget extends StatefulWidget {
  final bool useCustomMedication;

  const NewDrugControlAdministrationWidget({
    Key? key,
    required this.useCustomMedication,
  }) : super(key: key);

  @override
  _NewDrugControlAdministrationWidgetState createState() =>
      _NewDrugControlAdministrationWidgetState();
}

class _NewDrugControlAdministrationWidgetState
    extends State<NewDrugControlAdministrationWidget> {
  final NewDrugControlAdministrationStore store = Modular.get();
  final TextEditingController textController = TextEditingController();
  final NewDrugControlStore drugControlStore = Modular.get();

  @override
  void initState() {
    if (widget.useCustomMedication) {
      store.getAdministrations();
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
    return TripleBuilder<NewDrugControlAdministrationStore, DioError,
        List<KeyValueModel>>(
      store: store,
      builder: (_, triple) {
        if (!widget.useCustomMedication) {
          return SelectFieldWidget<MapEntry>(
            showSearch: true,
            label: DrugControlLabels.newDrugControlAdministrationLabel,
            items: DRUG_CONTROL_VIA_ADMIN.entries.toList(),
            itemsLabels: DRUG_CONTROL_VIA_ADMIN.values.toList(),
            placeholder:
                DrugControlLabels.newDrugControlAdministrationPlaceholder,
            controller: textController,
            onSelectItem: (MapEntry admin) {
              textController.text = admin.value;
              drugControlStore.state.administration = admin.value;
              store.update(store.state);
            },
          );
        }
        return GestureDetector(
          onTap: () {
            store.getAdministrations();
          },
          child: SelectFieldWidget<KeyValueModel>(
            label: DrugControlLabels.newDrugControlAdministrationLabel,
            items: triple.state,
            itemsLabels: triple.state.map((admin) {
              return admin.value!;
            }).toList(),
            isLoading: triple.isLoading,
            placeholder:
                DrugControlLabels.newDrugControlAdministrationPlaceholder,
            controller: textController,
            onSelectItem: (KeyValueModel admin) {
              textController.text = admin.value!;
              drugControlStore.state.administration = admin.value;
              drugControlStore.update(drugControlStore.state);
            },
            isEnabled: triple.event != TripleEvent.error &&
                (triple.state.isNotEmpty && !triple.isLoading),
            errorText: triple.event == TripleEvent.error
                ? DrugControlLabels.newDrugControlGeneralError
                : triple.state.isEmpty && !triple.isLoading
                    ? DrugControlLabels.newDrugControlAdministrationEmptyError
                    : null,
          ),
        );
      },
    );
  }
}
