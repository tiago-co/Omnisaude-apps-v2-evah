import 'package:omni_mediktor/src/core/models/session_conclusion_object_model.dart';

class DiagnosisResultModel {
  final int? urgency;
  final String? reason;
  final List<SessionConclusionObject>? sessionConclusions;

  DiagnosisResultModel({
    this.urgency,
    this.reason,
    this.sessionConclusions,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['urgencia'] = urgency;
    data['razao'] = reason;
    data['conclusoes'] =
        sessionConclusions?.map(_convertSessionConclusion).toList();
    return data;
  }

  Map<String, dynamic> _convertSessionConclusion(
    SessionConclusionObject sessionConclusion,
  ) {
    return {
      'descricao': sessionConclusion.description,
      'icd9': '${sessionConclusion.icd9}',
      'icd10': '${sessionConclusion.icd10}',
      'especialidades': sessionConclusion.specialties,
      'especialidadesId': sessionConclusion.specialtiesId,
      'porcentagem': sessionConclusion.percentage,
    };
  }
}
