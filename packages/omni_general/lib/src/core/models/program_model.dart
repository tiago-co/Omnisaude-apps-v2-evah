import 'package:omni_general/src/core/enums/home_layout_enum.dart';
import 'package:omni_general/src/core/enums/program_type_enum.dart';
import 'package:omni_general/src/core/enums/status_type_enum.dart';

import 'package:omni_general/src/core/models/juridical_person_model.dart';
import 'package:omni_general/src/core/models/program_current_phase_model.dart';

class ProgramModel {
  String? id;
  String? name;
  String? description;
  String? code;
  StatusType? status;
  String? reasonInactivity;
  ProgramCurrentPhaseModel? currentPhase;
  JuridicalPersonModel? enterprise;
  ProgramType? programType;
  DiseaseModel? disease;
  StatusType? statusPsp;
  HomeLayoutType? homeLayout;
  late final bool activeImplant;

  ProgramModel({
    this.id,
    this.name,
    this.description,
    this.code,
    this.status,
    this.reasonInactivity,
    this.currentPhase,
    this.enterprise,
    this.programType,
    this.disease,
    this.statusPsp,
    this.homeLayout,
    this.activeImplant = false,
  });

  ProgramModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
    description = json['descricao'];
    code = json['codigo_psp'];
    status = statusTypeFromJson(json['status']);
    reasonInactivity = json['motivo_inatividade'];
    if (json['fase_atual'] != null) {
      currentPhase = ProgramCurrentPhaseModel.fromJson(json['fase_atual']);
    } else {
      currentPhase = null;
    }
    if (json['empresa'] != null) {
      enterprise = JuridicalPersonModel.fromJson(json['empresa']);
    } else {
      enterprise = null;
    }
    programType = programTypeFromJson(json['tipo']);
    if (json['doenca'] != null) {
      disease = DiseaseModel.fromJson(json['doenca']);
    } else {
      disease = null;
    }
    statusPsp = statusTypeFromJson(json['status_psp']);
    homeLayout = homeLayoutTypeFromJson(json['layout']);
    activeImplant = json['implante_ativo'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = name;
    data['descricao'] = description;
    data['codigo_psp'] = code;
    data['status'] = status?.toJson;
    data['motivo_inatividade'] = reasonInactivity;
    data['fase_atual'] = currentPhase?.toJson();
    data['empresa'] = enterprise?.toJson();
    data['tipo'] = programType?.toJson;
    data['doenca'] = disease?.toJson();
    data['status_psp'] = statusPsp?.toJson;
    data['layout'] = homeLayout?.toJson;
    data['implante_ativo'] = activeImplant;
    return data;
  }
}

class DiseaseModel {
  int? id;
  String? base;
  String? code;
  String? name;

  DiseaseModel({this.id, this.base, this.code, this.name});

  DiseaseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    base = json['base'];
    code = json['codigo'];
    name = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['base'] = base;
    data['codigo'] = code;
    data['nome'] = name;
    return data;
  }
}
