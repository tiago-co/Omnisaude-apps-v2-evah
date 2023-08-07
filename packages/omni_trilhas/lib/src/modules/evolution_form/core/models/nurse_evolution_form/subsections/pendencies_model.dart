import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class PendenciesModel {
  String? id;
  String? exams;
  String? procedures;
  String? otherPendingIssues;
  String? intercurrences24h;

  PendenciesModel({
    this.exams,
    this.id,
    this.intercurrences24h,
    this.otherPendingIssues,
    this.procedures,
  });

  PendenciesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    exams = json['exames'];
    procedures = json['procedimentos'];
    otherPendingIssues = json['outras_pendencias'];
    intercurrences24h = json['intercorrencias_24h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['exames'] = exams;
    data['procedimentos'] = procedures;
    data['outras_pendencias'] = otherPendingIssues;
    data['intercorrencias_24h'] = intercurrences24h;
    return data;
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['Exames'] = buildFieldMap(
      type: 'simple',
      value: exams,
    );
    data['Procedimentos'] = buildFieldMap(
      type: 'simple',
      value: procedures,
    );
    data['Outras Pendências'] = buildFieldMap(
      type: 'simple',
      value: otherPendingIssues,
    );
    data['Intercorrencias 24 Horas'] = buildFieldMap(
      type: 'simple',
      value: intercurrences24h,
    );

    return data;
  }
}
