import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class Indicators24HoursModel {
  num? evacuations24Hours;
  num? diuresis24Hours;
  num? earnings24Hours;
  num? maxTemperature24Hours;
  num? hgt24Hours;
  num? balance24Hours;

  Indicators24HoursModel({
    this.balance24Hours,
    this.diuresis24Hours,
    this.earnings24Hours,
    this.evacuations24Hours,
    this.hgt24Hours,
    this.maxTemperature24Hours,
  });

  Indicators24HoursModel.fromJson(Map<String, dynamic> json) {
    balance24Hours = json['balanco_24h'];
    diuresis24Hours = json['diurese_24h'];
    earnings24Hours = json['ganhos_24h'];
    evacuations24Hours = json['evacuacoes_24h'];
    hgt24Hours = json['hgt_24h'];
    maxTemperature24Hours = json['temperatura_max_24h'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['balanco_24h'] = balance24Hours;
    data['diurese_24h'] = diuresis24Hours;
    data['ganhos_24h'] = earnings24Hours;
    data['evacuacoes_24h'] = evacuations24Hours;
    data['hgt_24h'] = hgt24Hours;
    data['temperatura_max_24h'] = maxTemperature24Hours;
    return data;
  }

  Map<String, dynamic> getData() {
    Map<String, dynamic> data = {};

    data['Balanço'] = buildFieldMap(
      type: 'simple',
      value: balance24Hours.toString(),
    );
    data['Diurese'] = buildFieldMap(
      type: 'simple',
      value: diuresis24Hours.toString(),
    );
    data['Ganhos'] = buildFieldMap(
      type: 'simple',
      value: earnings24Hours.toString(),
    );
    data['Evacuações'] = buildFieldMap(
      type: 'simple',
      value: evacuations24Hours.toString(),
    );
    data['HGT'] = buildFieldMap(
      type: 'simple',
      value: hgt24Hours.toString(),
    );
    data['Temperatura Máxima'] = buildFieldMap(
      type: 'simple',
      value: maxTemperature24Hours.toString(),
    );

    return data;
  }
}
