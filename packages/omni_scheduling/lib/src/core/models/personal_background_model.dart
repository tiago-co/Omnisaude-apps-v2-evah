import 'package:omni_scheduling/src/core/models/medical_records_field_model.dart';

class PersonalBackgroundModel {
  String? id;
  late List<MedicalRecordsFieldModel> vaccines;
  late List<MedicalRecordsFieldModel> alergias;
  late List<MedicalRecordsFieldModel> clinicalBackground;
  late List<MedicalRecordsFieldModel> familyHistory;
  late List<MedicalRecordsFieldModel> habits;
  late List<MedicalRecordsFieldModel> surgicalBackground;

  PersonalBackgroundModel({
    this.id,
    this.vaccines = const [],
    this.alergias = const [],
    this.clinicalBackground = const [],
    this.familyHistory = const [],
    this.habits = const [],
    this.surgicalBackground = const [],
  });

  PersonalBackgroundModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['vacinas'] != null) {
      vaccines = List<MedicalRecordsFieldModel>.empty(growable: true);
      json['vacinas'].forEach((v) {
        vaccines.add(MedicalRecordsFieldModel.fromJson(v));
      });
    }
    if (json['alergias'] != null) {
      alergias = List<MedicalRecordsFieldModel>.empty(growable: true);
      json['alergias'].forEach((v) {
        alergias.add(MedicalRecordsFieldModel.fromJson(v));
      });
    }
    if (json['antecedentes_clinicos'] != null) {
      clinicalBackground = List<MedicalRecordsFieldModel>.empty(growable: true);
      json['antecedentes_clinicos'].forEach((v) {
        clinicalBackground.add(MedicalRecordsFieldModel.fromJson(v));
      });
    }
    if (json['antecedentes_clinicos_familiar'] != null) {
      familyHistory = List<MedicalRecordsFieldModel>.empty(growable: true);
      json['antecedentes_clinicos_familiar'].forEach((v) {
        familyHistory.add(MedicalRecordsFieldModel.fromJson(v));
      });
    }
    if (json['habitos'] != null) {
      habits = List<MedicalRecordsFieldModel>.empty(growable: true);
      json['habitos'].forEach((v) {
        habits.add(MedicalRecordsFieldModel.fromJson(v));
      });
    }
    if (json['antecedentes_cirurgicos'] != null) {
      surgicalBackground = List<MedicalRecordsFieldModel>.empty(growable: true);
      json['antecedentes_cirurgicos'].forEach((v) {
        surgicalBackground.add(MedicalRecordsFieldModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vacinas'] = vaccines.map((v) => v.toJson()).toList();
    data['alergias'] = alergias.map((v) => v.toJson()).toList();
    data['antecedentes_clinicos'] =
        clinicalBackground.map((v) => v.toJson()).toList();
    data['antecedentes_clinicos_familiar'] =
        familyHistory.map((v) => v.toJson()).toList();
    data['habitos'] = habits.map((v) => v.toJson()).toList();
    data['antecedentes_cirurgicos'] =
        surgicalBackground.map((v) => v.toJson()).toList();
    return data;
  }
}
