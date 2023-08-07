import 'package:omni_core/src/app/core/enums/procedure_enum.dart';

class ProcedureParamsModel {
  String? name;
  String? limit;
  String? startDate;
  String? endDate;
  ProcedureType? type;

  ProcedureParamsModel({
    this.name,
    this.limit,
    this.startDate,
    this.endDate,
    this.type,
  });

  ProcedureParamsModel.fromJson(Map<String, dynamic> json) {
    name = json['nome'];
    limit = json['limit'];
    endDate = json['data_fim'];
    startDate = json['data_inicio'];
    type = procedureTypeFromJson(json['typo']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = name;
    data['limit'] = limit;
    data['data_inicio'] = startDate;
    data['data_fim'] = endDate;
    return data;
  }
}
