import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:omni_bot/src/core/models/event_model.dart';
import 'package:omni_bot/src/core/models/file_model.dart';
import 'package:omni_bot/src/core/models/input_model.dart';
import 'package:omni_bot/src/core/models/message_model.dart';
import 'package:omni_bot/src/core/models/select_model.dart';
import 'package:omni_bot/src/core/models/upload_model.dart';

class BotMessageModel {
  Timestamp? dateTimeTimeStamp;
  FieldValue? datetimeFieldValue;
  String? peer;
  String? avatarUrl;
  String? username;
  String? name;
  InputModel? input;
  UploadModel? upload;
  SelectModel? select;
  MessageModel? message;
  FileModel? file;
  EventModel? event;

  BotMessageModel({
    this.dateTimeTimeStamp,
    this.datetimeFieldValue,
    this.peer,
    this.avatarUrl,
    this.username,
    this.input,
    this.upload,
    this.select,
    this.message,
    this.file,
    this.event,
    this.name,
  });

  BotMessageModel.fromJson(Map<String, dynamic> json) {
    if (json['datetime'] is Timestamp) {
      dateTimeTimeStamp = json['datetime'];
    } else {
      dateTimeTimeStamp = Timestamp.fromDate(
        DateTime.parse(json['datetime']).toUtc(),
      );
    }
    peer = json['peer'];
    avatarUrl = json['avatarUrl'];
    username = json['username'];
    name = json['name'];
    input = json['input'] != null ? InputModel.fromJson(json['input']) : null;
    upload =
        json['upload'] != null ? UploadModel.fromJson(json['upload']) : null;
    select =
        json['switch'] != null ? SelectModel.fromJson(json['switch']) : null;
    message =
        json['message'] != null ? MessageModel.fromJson(json['message']) : null;
    file = json['file'] != null ? FileModel.fromJson(json['file']) : null;
    event = json['event'] != null ? EventModel.fromJson(json['event']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['datetime'] = datetimeFieldValue;
    data['peer'] = peer;
    data['avatarUrl'] = avatarUrl;
    data['username'] = username;
    data['name'] = name;
    data['input'] = input?.toJson();
    data['upload'] = upload?.toJson();
    data['switch'] = select?.toJson();
    data['message'] = message?.toJson();
    data['file'] = file?.toJson();
    data['event'] = event?.toJson();
    return data;
  }
}
