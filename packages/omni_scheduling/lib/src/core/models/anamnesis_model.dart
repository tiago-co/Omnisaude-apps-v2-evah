import 'package:omni_scheduling/src/core/models/medical_records_field_model.dart';

class AnamnesisModel {
  String? id;
  late List<MedicalRecordsFieldModel> complaints;
  String? diseaseHistory;

  AnamnesisModel({
    this.id,
    this.complaints = const [],
    this.diseaseHistory,
  });

  AnamnesisModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['queixas'] != null) {
      complaints = List<MedicalRecordsFieldModel>.empty(growable: true);
      json['queixas'].forEach((v) {
        complaints.add(MedicalRecordsFieldModel.fromJson(v));
      });
    }
    diseaseHistory = json['historia_doenca'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['queixas'] = complaints.map((v) => v.toJson()).toList();
    data['historia_doenca'] = diseaseHistory;
    return data;
  }
}
