import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_unity_store.dart';
import 'package:omni_drug_control/src/core/constants/unity.dart';
import 'package:omni_drug_control_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class NewDrugControlUnityWidget extends StatefulWidget {
  final bool useCustomMedication;

  const NewDrugControlUnityWidget({
    Key? key,
    required this.useCustomMedication,
  }) : super(key: key);

  @override
  _NewDrugControlUnityWidgetState createState() => _NewDrugControlUnityWidgetState();
}

class _NewDrugControlUnityWidgetState extends State<NewDrugControlUnityWidget> {
  final NewDrugControlUnityStore store = Modular.get();
  final TextEditingController textController = TextEditingController();
  final NewDrugControlStore drugControlStore = Modular.get();

  @override
  void initState() {
    if (widget.useCustomMedication) {
      store.getUnities();
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
    return TripleBuilder<NewDrugControlUnityStore, DioError, List<KeyValueModel>>(
      store: store,
      builder: (_, triple) {
        if (!widget.useCustomMedication) {
          return SelectFieldWidget<MapEntry>(
            showSearch: true,
            label: DrugControlLabels.newDrugControlUnityLabel,
            items: DRUG_CONTROL_UNITIES.entries.toList(),
            itemsLabels: DRUG_CONTROL_UNITIES.values.toList(),
            placeholder: DrugControlLabels.newDrugControlUnityPlaceholder,
            controller: textController,
            padding: EdgeInsets.zero,
            onSelectItem: (MapEntry unity) {
              textController.text = unity.value;
              drugControlStore.state.unity = unity.value;
              drugControlStore.update(drugControlStore.state);
            },
          );
        }
        return GestureDetector(
          onTap: () {
            store.getUnities();
          },
          child: SelectFieldWidget<KeyValueModel>(
            label: DrugControlLabels.newDrugControlUnityLabel,
            items: triple.state,
            itemsLabels: triple.state.map((unity) {
              return unity.value!;
            }).toList(),
            isLoading: triple.isLoading,
            placeholder: DrugControlLabels.newDrugControlUnityPlaceholder,
            controller: textController,
            onSelectItem: (unity) {
              textController.text = unity.value!;
              drugControlStore.state.unity = unity.value;
              drugControlStore.update(drugControlStore.state);
            },
            isEnabled: triple.event != TripleEvent.error && (triple.state.isNotEmpty && !triple.isLoading),
            errorText: triple.event == TripleEvent.error
                ? DrugControlLabels.newDrugControlGeneralError
                : triple.state.isEmpty && !triple.isLoading
                    ? DrugControlLabels.newDrugControlUnityEmptyError
                    : null,
          ),
        );
      },
    );
  }
}
