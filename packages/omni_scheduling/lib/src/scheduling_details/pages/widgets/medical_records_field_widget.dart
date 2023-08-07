import 'package:flutter/material.dart';
import 'package:omni_scheduling/src/core/models/medical_records_model.dart';

import 'package:omni_scheduling/src/scheduling_details/pages/widgets/medical_records_expansion_widget.dart';
import 'package:omni_scheduling/src/scheduling_details/pages/widgets/medical_records_subtitle_widget.dart';
import 'package:omni_scheduling/src/scheduling_details/pages/widgets/medical_records_title_widget.dart';
import 'package:omni_scheduling/src/scheduling_details/pages/widgets/medical_records_value_widget.dart';

class MedicalRecordsFieldWidget extends StatelessWidget {
  final MedicalRecordsModel medicalRecords;
  const MedicalRecordsFieldWidget({
    Key? key,
    required this.medicalRecords,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAnamnesisWidget(context),
        const SizedBox(height: 15),
        _buildPersonalBackgroundWidget(context),
        const SizedBox(height: 15),
        _buildDiagnosisWidget(context),
      ],
    );
  }

  Widget _buildAnamnesisWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor.withOpacity(0.025),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MedicalRecordsTitleWidget(
            title: 'História e motivo do atendimento',
          ),
          const SizedBox(height: 15),
          const MedicalRecordsSubtitleWidget(subtitle: 'Queixas'),
          const Divider(),
          const SizedBox(height: 5),
          if (medicalRecords.anamnesis == null)
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: MedicalRecordsValueWidget(value: 'Não informado.'),
            ),
          if (medicalRecords.anamnesis != null)
            Column(
              children: medicalRecords.anamnesis!.complaints.map((field) {
                return MedicalRecordsExpansionWidget(
                  field: field,
                  subtitle: field.type,
                );
              }).toList(),
            ),
          const MedicalRecordsSubtitleWidget(
            subtitle: 'História da doença atual',
          ),
          const Divider(),
          const SizedBox(height: 5),
          MedicalRecordsValueWidget(
            value: medicalRecords.anamnesis?.diseaseHistory ?? 'Não informado.',
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalBackgroundWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor.withOpacity(0.025),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MedicalRecordsTitleWidget(
            title: 'Antecedentes pessoais',
          ),
          const SizedBox(height: 15),
          const MedicalRecordsSubtitleWidget(
            subtitle: 'Antecedentes clínicos',
          ),
          const Divider(),
          const SizedBox(height: 5),
          if (medicalRecords.personalBackground?.clinicalBackground == null)
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: MedicalRecordsValueWidget(value: 'Não informado.'),
            ),
          if (medicalRecords.personalBackground?.clinicalBackground != null)
            Column(
              children: medicalRecords.personalBackground!.clinicalBackground
                  .map((field) {
                return MedicalRecordsExpansionWidget(
                  field: field,
                  subtitle: field.type,
                );
              }).toList(),
            ),
          const MedicalRecordsSubtitleWidget(
            subtitle: 'Antecedentes cirúrgicos',
          ),
          const Divider(),
          const SizedBox(height: 5),
          if (medicalRecords.personalBackground?.surgicalBackground == null)
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: MedicalRecordsValueWidget(value: 'Não informado.'),
            ),
          if (medicalRecords.personalBackground?.surgicalBackground != null)
            Column(
              children: medicalRecords.personalBackground!.surgicalBackground
                  .map((field) {
                return MedicalRecordsExpansionWidget(
                  field: field,
                  subtitle: field.type,
                );
              }).toList(),
            ),
          const MedicalRecordsSubtitleWidget(subtitle: 'Hábitos'),
          const Divider(),
          const SizedBox(height: 5),
          if (medicalRecords.personalBackground?.habits == null)
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: MedicalRecordsValueWidget(value: 'Não informado.'),
            ),
          if (medicalRecords.personalBackground?.habits != null)
            Column(
              children: medicalRecords.personalBackground!.habits.map((field) {
                return MedicalRecordsExpansionWidget(
                  field: field,
                  subtitle: field.type,
                );
              }).toList(),
            ),
          const MedicalRecordsSubtitleWidget(subtitle: 'Alergias'),
          const Divider(),
          const SizedBox(height: 5),
          if (medicalRecords.personalBackground?.alergias == null)
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: MedicalRecordsValueWidget(value: 'Não informado.'),
            ),
          if (medicalRecords.personalBackground?.alergias != null)
            Column(
              children:
                  medicalRecords.personalBackground!.alergias.map((field) {
                return MedicalRecordsExpansionWidget(
                  field: field,
                  subtitle: field.type,
                );
              }).toList(),
            ),
          const MedicalRecordsSubtitleWidget(subtitle: 'Vacinas'),
          const Divider(),
          const SizedBox(height: 5),
          if (medicalRecords.personalBackground?.vaccines == null)
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: MedicalRecordsValueWidget(value: 'Não informado.'),
            ),
          if (medicalRecords.personalBackground?.vaccines != null)
            Column(
              children:
                  medicalRecords.personalBackground!.vaccines.map((field) {
                return MedicalRecordsExpansionWidget(
                  field: field,
                  subtitle: field.type,
                );
              }).toList(),
            ),
          const MedicalRecordsSubtitleWidget(
            subtitle: 'Antecedentes clínicos familiares',
          ),
          const Divider(),
          const SizedBox(height: 5),
          if (medicalRecords.personalBackground?.familyHistory == null)
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: MedicalRecordsValueWidget(value: 'Não informado.'),
            ),
          if (medicalRecords.personalBackground?.familyHistory != null)
            Column(
              children:
                  medicalRecords.personalBackground!.familyHistory.map((field) {
                return MedicalRecordsExpansionWidget(
                  field: field,
                  subtitle: field.type,
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildDiagnosisWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor.withOpacity(0.025),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MedicalRecordsTitleWidget(title: 'Hipótese diagnóstica'),
          const SizedBox(height: 15),
          const SizedBox(height: 5),
          if (medicalRecords.diagnosis?.doencasDiagnosticadas == null)
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: MedicalRecordsValueWidget(value: 'Não informado.'),
            ),
          if (medicalRecords.diagnosis?.doencasDiagnosticadas != null)
            Column(
              children:
                  medicalRecords.diagnosis!.doencasDiagnosticadas.map((field) {
                return MedicalRecordsExpansionWidget(
                  field: field,
                  subtitle: field.type,
                );
              }).toList(),
            ),
          const MedicalRecordsSubtitleWidget(subtitle: 'Novos diagnósticos'),
          const Divider(),
          const SizedBox(height: 5),
          MedicalRecordsValueWidget(
            value: medicalRecords.diagnosis?.impressaoDiagnostica ??
                'Não informado.',
          ),
        ],
      ),
    );
  }
}
