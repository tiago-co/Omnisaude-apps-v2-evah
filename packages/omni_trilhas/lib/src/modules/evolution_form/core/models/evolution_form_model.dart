import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/evolution_form_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/filed_by_model.dart';

class EvolutionFormModel {
  String? id;
  EvolutionFormType? evolutionFormType;
  String? createdAt;
  String? bed;
  String? attendanceNumber;
  FiledByModel? filedBy;

  EvolutionFormModel({
    this.id,
    this.evolutionFormType,
    this.bed,
    this.createdAt,
    this.attendanceNumber,
    this.filedBy,
  });

  EvolutionFormModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    evolutionFormType = evolutionFormTypeFromJson(json['tipo']);
    createdAt = json['criado_em'];
    bed = json['leito'];
    attendanceNumber = json['nr_atendimento'];
    filedBy = FiledByModel.fromJson(json['preenchido_por']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['tipo'] = evolutionFormType?.toJson;
    data['criado_em'] = createdAt;
    data['leito'] = bed;
    data['nr_atendimento'] = attendanceNumber;
    data['preenchido_por'] = filedBy?.toJson();
    return data;
  }
}
