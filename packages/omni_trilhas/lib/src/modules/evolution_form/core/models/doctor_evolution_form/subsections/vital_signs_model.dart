import 'package:omni_trilhas/src/modules/evolution_form/core/models/filed_by_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class VitalSignsModel {
  String? id;
  num? heartRate;
  num? respiratoryRate;
  num? pas;
  num? pad;
  num? o2Saturation;
  String? fullHour;
  FiledByModel? filedBy;

  VitalSignsModel({
    this.heartRate,
    this.id,
    this.o2Saturation,
    this.pad,
    this.pas,
    this.respiratoryRate,
    this.filedBy,
  });

  VitalSignsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    heartRate = json['frequencia_cardiaca'];
    o2Saturation = json['saturacao_o2'];
    pad = json['pad'];
    pas = json['pas'];
    respiratoryRate = json['frequencia_respiratoria'];
    fullHour = json['hora_cheia'];
    filedBy = FiledByModel.fromJson(json['preenchido_por']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['frequencia_cardiaca'] = heartRate;
    data['saturacao_o2'] = o2Saturation;
    data['pad'] = pad;
    data['pas'] = pas;
    data['frequencia_respiratoria'] = respiratoryRate;
    data['hora_cheia'] = fullHour;
    data['preenchido_por'] = filedBy?.toJson();
    return data;
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['Frequência Cardiaca'] = buildFieldMap(
      type: 'simple',
      value: heartRate.toString(),
    );
    data['Saturação O2'] = buildFieldMap(
      type: 'simple',
      value: o2Saturation.toString(),
    );
    data['pad'] = buildFieldMap(
      type: 'simple',
      value: pad.toString(),
    );
    data['pas'] = buildFieldMap(
      type: 'simple',
      value: pas.toString(),
    );
    data['Frequência Respiratória'] = buildFieldMap(
      type: 'simple',
      value: respiratoryRate.toString(),
    );
    data['Hora'] = buildFieldMap(
      type: 'simple',
      value: fullHour,
    );
    data['preenchido Por'] = buildFieldMap(
      type: 'simple',
      value: filedBy?.nome,
    );
    return data;
  }
}
