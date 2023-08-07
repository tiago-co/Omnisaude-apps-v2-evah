import 'package:omni_general/omni_general.dart';

class ProgramCurrentPhaseModel {
  String? id;
  int? order;
  String? name;
  String? description;
  List<ModuleModel>? modules;

  ProgramCurrentPhaseModel({
    this.id,
    this.name,
    this.description,
    this.order,
    this.modules,
  });

  ProgramCurrentPhaseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
    description = json['descricao'];
    order = json['ordem'];
    if (json['modulo'] != null) {
      modules = List<ModuleModel>.empty(growable: true);
      json['modulo'].forEach((v) {
        modules!.add(ModuleModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = name;
    data['descricao'] = description;
    data['ordem'] = order;
    data['modulo'] = modules?.map((v) => v.toJson()).toList();
    return data;
  }
}
