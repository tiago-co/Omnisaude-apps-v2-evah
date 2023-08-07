import 'package:flutter/material.dart';
import 'package:omni_scheduling/src/core/models/dynamic_medical_records_model.dart';

import 'package:omni_scheduling/src/scheduling_details/pages/widgets/medical_records_subtitle_widget.dart';
import 'package:omni_scheduling/src/scheduling_details/pages/widgets/medical_records_title_widget.dart';
import 'package:omni_scheduling/src/scheduling_details/pages/widgets/medical_records_value_widget.dart';

class DynamicMedicalRecordsFieldWidget extends StatelessWidget {
  final DynamicMedicalRecordsFieldModel field;
  const DynamicMedicalRecordsFieldWidget({
    Key? key,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor.withOpacity(0.025),
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MedicalRecordsTitleWidget(title: field.field ?? 'Sem título'),
          const SizedBox(height: 15),
          MedicalRecordsSubtitleWidget(
            subtitle: field.description ?? 'Sem descrição',
          ),
          const Divider(),
          const SizedBox(height: 5),
          MedicalRecordsValueWidget(value: field.value ?? 'Não informado.'),
        ],
      ),
    );
  }
}
