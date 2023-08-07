import 'package:omni_core/src/app/core/enums/procedure_enum.dart';

class CrisisDiaryParamsModel {
  String? name;
  String? limit;
  String? startDate;
  String? endDate;
  ProcedureType? type;

  CrisisDiaryParamsModel({
    this.name,
    this.limit,
    this.startDate,
    this.endDate,
    this.type,
  });

  CrisisDiaryParamsModel.fromJson(Map<String, dynamic> json) {
    name = json['nome'];
    limit = json['limit'];
    startDate = json['data_inicio'];
    endDate = json['data_fim'];
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
