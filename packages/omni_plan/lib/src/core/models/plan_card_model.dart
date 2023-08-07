import 'package:omni_general/omni_general.dart'
    show statusTypeFromJson, StatusType, StatusTypeExtension;

import 'package:omni_plan/src/core/models/plan_model.dart';

class PlanCardModel {
  String? id;
  PlanModel? plan;
  StatusType? status;
  String? code;
  String? matricula;
  String? vencimento;
  String? category;

  PlanCardModel({
    this.id,
    this.plan,
    this.status,
    this.code,
    this.matricula,
    this.vencimento,
    this.category,
  });

  PlanCardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plan = json['plano'] != null ? PlanModel.fromJson(json['plano']) : null;
    status = statusTypeFromJson(json['status']);
    code = json['codigo'];
    matricula = json['matricula'];
    vencimento = json['vencimento'];
    category = json['categoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plano'] = plan?.toJson();
    data['status'] = status?.toJson;
    data['codigo'] = code;
    data['matricula'] = matricula;
    data['vencimento'] = vencimento;
    data['categoria'] = category;
    return data;
  }
}
