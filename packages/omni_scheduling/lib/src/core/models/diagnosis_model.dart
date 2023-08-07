import 'package:omni_scheduling/src/core/models/medical_records_field_model.dart';

class DiagnosisModel {
  String? id;
  late List<MedicalRecordsFieldModel> doencasDiagnosticadas;
  String? impressaoDiagnostica;

  DiagnosisModel({
    this.id,
    this.doencasDiagnosticadas = const [],
    this.impressaoDiagnostica,
  });

  DiagnosisModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['doencas_diagnosticadas'] != null) {
      doencasDiagnosticadas = List<MedicalRecordsFieldModel>.empty(
        growable: true,
      );
      json['doencas_diagnosticadas'].forEach((v) {
        doencasDiagnosticadas.add(MedicalRecordsFieldModel.fromJson(v));
      });
    }
    impressaoDiagnostica = json['impressao_diagnostica'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doencas_diagnosticadas'] =
        doencasDiagnosticadas.map((v) => v.toJson()).toList();
    data['impressao_diagnostica'] = impressaoDiagnostica;
    return data;
  }
}
