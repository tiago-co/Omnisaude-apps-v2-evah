import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:omni_core/src/app/core/enums/notification_enum.dart';
import 'package:omni_general/omni_general.dart';

class NotificationModel {
  String? id;
  String? title;
  String? message;
  NotificationType? type;
  Timestamp? createdAt;
  NotificationPriority? priority;
  TargetModel? origem;
  TargetModel? destino;
  String? content;
  String? banner;
  late bool seen;
  late bool removed;

  NotificationModel({
    this.id,
    this.title,
    this.message,
    this.type,
    this.createdAt,
    this.priority,
    this.origem,
    this.destino,
    this.content,
    this.banner,
    this.seen = false,
    this.removed = false,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['titulo'];
    message = json['mensagem'];
    type = notificationTypeFromJson(json['tipo']);
    createdAt = json['criado_em'];
    priority = notificationPriorityFromJson(json['prioridade']);
    origem =
        json['origem'] != null ? TargetModel.fromJson(json['origem']) : null;
    destino =
        json['destino'] != null ? TargetModel.fromJson(json['destino']) : null;
    content = json['conteudo'];
    banner = json['banner'];
    seen = json['visualizado'] ?? false;
    removed = json['removido'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['titulo'] = title;
    data['mensagem'] = message;
    data['tipo'] = type?.toJson;
    data['criado_em'] = createdAt;
    data['prioridade'] = priority?.toJson;
    data['origem'] = origem?.toJson();
    data['destino'] = destino?.toJson();
    data['conteudo'] = content;
    data['banner'] = banner;
    data['visualizado'] = seen;
    data['removido'] = removed;
    return data;
  }
}

class TargetModel {
  ModuleType? type;
  ModuleCategoryType? category;

  TargetModel({this.type, this.category});

  TargetModel.fromJson(Map<String, dynamic> json) {
    type = moduleTypeFromJson(json['modulo']);
    category = categoryTypeFromJson(json['categoria']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['modulo'] = type?.toJson;
    data['categoria'] = category?.toJson;
    return data;
  }
}
