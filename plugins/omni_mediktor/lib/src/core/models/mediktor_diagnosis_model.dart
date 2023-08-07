import 'package:omni_mediktor/src/core/enums/mediktor_urgency_enum.dart';

import 'package:omni_mediktor/src/core/models/session_conclusions_model.dart';

class MediktorDiagnosisModel {
  String? externUserId;
  String? deviceId;
  String? sessionId;
  num? date;
  String? timezoneId;
  String? reason;
  num? type;
  num? phase;
  num? subPhase;
  num? validation;
  num? age;
  String? gender;
  String? apiVersion;
  String? language;
  MediktorUrgency? urgency;
  MediktorUrgency? urgencyEnum;
  MediktorUrgency? urgencyMain;
  MediktorUrgency? urgencyMainEnum;
  MediktorUrgency? urgencySecundary;
  MediktorUrgency? urgencySecundaryEnum;
  num? lastEdited;
  bool? isActive;
  List? answers;
  List? inputRecognition;
  List? inputRecommendation;
  SessionConclusions? sessionConclusions;
  String? summarySessionRecommendation;

  MediktorDiagnosisModel({
    this.externUserId,
    this.deviceId,
    this.sessionId,
    this.date,
    this.timezoneId,
    this.reason,
    this.type,
    this.phase,
    this.subPhase,
    this.validation,
    this.age,
    this.gender,
    this.apiVersion,
    this.language,
    this.urgency,
    this.urgencyEnum,
    this.urgencyMain,
    this.urgencyMainEnum,
    this.urgencySecundary,
    this.urgencySecundaryEnum,
    this.lastEdited,
    this.isActive,
    this.answers,
    this.inputRecognition,
    this.inputRecommendation,
    this.sessionConclusions,
    this.summarySessionRecommendation,
  });

  MediktorDiagnosisModel.fromJson(Map<String, dynamic> json) {
    externUserId = json['externUserId'];
    deviceId = json['deviceId'];
    sessionId = json['sessionId'];
    date = json['date'];
    timezoneId = json['timezoneId'];
    reason = json['reason'];
    type = json['type'];
    phase = json['phase'];
    subPhase = json['subPhase'];
    validation = json['validation'];
    age = json['age'];
    gender = json['gender'] ?? '';
    apiVersion = json['apiVersion'];
    language = json['language'];
    urgency = mediktorUrgencyFromJson(json['urgency']);
    urgencyEnum = mediktorUrgencyFromJson(json['urgencyEnum']);
    urgencyMain = mediktorUrgencyFromJson(json['urgencyMain']);
    urgencyMainEnum = mediktorUrgencyFromJson(json['urgencyMainEnum']);
    urgencySecundary = mediktorUrgencyFromJson(json['urgencySecundary']);
    urgencySecundaryEnum =
        mediktorUrgencyFromJson(json['urgencySecundaryEnum']);
    lastEdited = json['lastEdited'];
    isActive = json['isActive'];
    if (json['sessionConclusions'] != null) {
      summarySessionRecommendation =
          json['sessionConclusions']['summarySessionRecommendation'];
    }

    if (json['answers'] != null) {
      answers = List.empty(growable: true);
      json['answers'].forEach((v) {
        answers!.add(v);
      });
    }
    if (json['inputRecognition'] != null) {
      inputRecognition = List.empty(growable: true);
      json['inputRecognition'].forEach((v) {
        inputRecognition!.add(v);
      });
    }
    if (json['inputRecommendation'] != null) {
      inputRecommendation = List.empty(growable: true);
      json['inputRecommendation'].forEach((v) {
        inputRecommendation!.add(v);
      });
    }
    if (json['sessionConclusions'] != null) {
      sessionConclusions =
          SessionConclusions.fromMap(json['sessionConclusions']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['externUserId'] = externUserId;
    data['deviceId'] = deviceId;
    data['sessionId'] = sessionId;
    data['date'] = date;
    data['timezoneId'] = timezoneId;
    data['reason'] = reason;
    data['type'] = type;
    data['phase'] = phase;
    data['subPhase'] = subPhase;
    data['validation'] = validation;
    data['age'] = age;
    data['gender'] = gender;
    data['apiVersion'] = apiVersion;
    data['language'] = language;
    data['urgency'] = urgency?.toJson;
    data['urgencyEnum'] = urgencyEnum?.toJson;
    data['urgencyMain'] = urgencyMain?.toJson;
    data['urgencyMainEnum'] = urgencyMainEnum?.toJson;
    data['urgencySecundary'] = urgencySecundary?.toJson;
    data['urgencySecundaryEnum'] = urgencySecundaryEnum?.toJson;
    data['lastEdited'] = lastEdited;
    data['isActive'] = isActive;
    data['answers'] = answers?.map((v) => v.toJson()).toList();
    data['inputRecognition'] =
        inputRecognition?.map((v) => v.toJson()).toList();
    data['inputRecommendation'] =
        inputRecommendation?.map((v) => v.toJson()).toList();
    return data;
  }
}
