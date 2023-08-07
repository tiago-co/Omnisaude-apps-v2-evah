import 'dart:convert';

import 'package:omni_mediktor/src/core/models/mediktor_diagnosis_model.dart';

class RecomendationModel {
  String? eventName;
  MediktorDiagnosisModel? diagnosis;
  RecomendationModel({
    this.eventName,
    this.diagnosis,
  });

  Map<String, dynamic> toMap() {
    return {
      'eventName': eventName,
      'diagnosis': diagnosis!.toJson(),
    };
  }

  factory RecomendationModel.fromMap(Map<String, dynamic> map) {
    return RecomendationModel(
      eventName: map['name'] ?? '',
      diagnosis: MediktorDiagnosisModel.fromJson(map['data'][0]['session']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecomendationModel.fromJson(String source) =>
      RecomendationModel.fromMap(json.decode(source));
}
