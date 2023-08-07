import 'package:cloud_firestore/cloud_firestore.dart';

class VideoCallModel {
  Timestamp? calledAt;
  String? calledBy;
  String? calledTo;
  Timestamp? acceptedAt;
  String? acceptedBy;
  Timestamp? rejectedAt;
  String? rejectedBy;
  Timestamp? finishedAt;
  String? finishedBy;
  String? token;

  VideoCallModel({
    this.calledAt,
    this.calledBy,
    this.calledTo,
    this.acceptedAt,
    this.acceptedBy,
    this.rejectedAt,
    this.rejectedBy,
    this.finishedAt,
    this.finishedBy,
    this.token,
  });

  VideoCallModel.fromJson(Map<String, dynamic> json) {
    calledAt = json['called_at'];
    calledBy = json['called_by'];
    calledTo = json['called_to'];
    acceptedAt = json['accepted_at'];
    acceptedBy = json['accepted_by'];
    rejectedAt = json['rejected_at'];
    rejectedBy = json['rejected_by'];
    finishedAt = json['finished_at'];
    finishedBy = json['finished_by'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['called_at'] = calledAt;
    data['called_by'] = calledBy;
    data['called_to'] = calledTo;
    data['accepted_at'] = acceptedAt;
    data['accepted_by'] = acceptedBy;
    data['rejected_at'] = rejectedAt;
    data['rejected_by'] = rejectedBy;
    data['finished_at'] = finishedAt;
    data['finished_by'] = finishedBy;
    data['token'] = token;
    return data;
  }
}
