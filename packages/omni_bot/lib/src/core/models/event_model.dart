
import 'package:omni_bot/src/core/enums/event_type_enum.dart';
import 'package:omni_bot/src/core/models/queue_model.dart';

class EventModel {
  String? message;
  String? imageUrl;
  EventType? eventType;
  List<QueueModel>? queue;

  EventModel({this.message, this.imageUrl, this.eventType, this.queue});

  EventModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    imageUrl = json['imageUrl'];
    eventType = eventTypeFromJson(json['eventType']);
    if (json['queue'] != null) {
      queue = List<QueueModel>.empty(growable: true);
      json['queue'].forEach((v) {
        queue!.add(QueueModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['imageUrl'] = imageUrl;
    data['eventType'] = eventType?.toJson;
    data['queue'] = queue?.map((v) => v.toJson()).toList();
    return data;
  }
}
