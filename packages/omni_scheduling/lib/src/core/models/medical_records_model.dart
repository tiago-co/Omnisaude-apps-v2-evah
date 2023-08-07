import 'package:omni_scheduling/src/core/models/anamnesis_model.dart';
import 'package:omni_scheduling/src/core/models/diagnosis_model.dart';
import 'package:omni_scheduling/src/core/models/personal_background_model.dart';

class MedicalRecordsModel {
  String? id;
  PersonalBackgroundModel? personalBackground;
  AnamnesisModel? anamnesis;
  DiagnosisModel? diagnosis;
  dynamic status;
  String? observation;
  String? prescricaoMemed;

  MedicalRecordsModel({
    this.id,
    this.personalBackground,
    this.anamnesis,
    this.diagnosis,
    this.status,
    this.observation,
    this.prescricaoMemed,
  });

  MedicalRecordsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    personalBackground = json['antecedente_pessoal'] != null
        ? PersonalBackgroundModel.fromJson(json['antecedente_pessoal'])
        : null;
    anamnesis = json['anamnese'] != null
        ? AnamnesisModel.fromJson(json['anamnese'])
        : null;
    diagnosis = json['diagnostico'] != null
        ? DiagnosisModel.fromJson(json['diagnostico'])
        : null;
    status = json['status'];
    observation = json['observacao'];
    prescricaoMemed = json['prescricao_memed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['antecedente_pessoal'] = personalBackground?.toJson();
    data['anamnese'] = anamnesis?.toJson();
    data['diagnostico'] = diagnosis?.toJson();
    data['status'] = status;
    data['observacao'] = observation;
    data['prescricao_memed'] = prescricaoMemed;
    return data;
  }
}
