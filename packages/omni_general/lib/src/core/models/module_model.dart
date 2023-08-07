import 'package:omni_general/src/core/enums/modules_enum.dart';

class ModuleModel {
  String? id;
  String? name;
  bool? active;
  String? botId;
  late ModuleType type;
  String? cardBanner;
  String? description;
  late ModuleCategoryType category;
  late bool important;

  ModuleModel({
    this.id,
    this.name,
    this.type = ModuleType.general,
    this.active,
    this.category = ModuleCategoryType.other,
    this.cardBanner,
    this.important = false,
    this.botId,
    this.description,
  });

  ModuleModel.fromJson(Map<String, dynamic> json) {
    name = json['nome'];
    active = json['ativo'];
    id = json['id'];
    type = moduleTypeFromJson(json['tipo']) ?? ModuleType.general;
    category = categoryTypeFromJson(json['categoria']);
    description = json['descricao'];
    cardBanner = json['logo'];
    important = json['importante'] ?? false;
    botId = json['bot_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = name;
    data['ativo'] = active;
    data['id'] = id;
    data['tipo'] = type.toJson;
    data['categoria'] = category.toJson;
    data['descricao'] = description;
    data['logo'] = cardBanner;
    data['importante'] = important;
    data['bot_id'] = botId;
    return data;
  }
}
