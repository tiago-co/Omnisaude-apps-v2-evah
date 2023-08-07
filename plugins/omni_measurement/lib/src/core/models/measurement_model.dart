import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/src/core/enums/feeling_type_enum.dart';
import 'package:omni_measurement/src/core/enums/meal_type_enum.dart';
import 'package:omni_measurement/src/core/enums/measurement_mode_enum.dart';
import 'package:omni_measurement/src/core/enums/measurement_type_enum.dart';

class MeasurementModel {
  String? currentMeasure;
  // String? currentMeasurePressure;
  MeasurementMode? measurementMode;
  String? date;
  AreYouFeeling? howAreYouFeeling;
  MealType? meal;
  String? observations;
  MeasurementType? measurementType;
  String? imageMeasure;

  MeasurementModel({
    this.currentMeasure,
    this.measurementMode,
    this.date,
    this.howAreYouFeeling,
    this.meal,
    this.observations,
    this.measurementType,
    this.imageMeasure,
  });

  MeasurementModel.fromJson(Map<String, dynamic> json) {
    currentMeasure = json['valor'];
    measurementMode = measurementModeFromJson(json['tipo']);
    howAreYouFeeling = areYouFeelingFromJson(json['sensacao']);
    date = json['data_envio'];
    meal = mealTypeFromJson(json['refeicao']);
    observations = json['observacoes'];
    measurementType = measurementTypeFromJson(json['dispositivo']);
    imageMeasure = json['b64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dispositivo'] = measurementType?.toJson;
    data['valor'] = currentMeasure;
    data['tipo'] = measurementMode?.toJson;
    data['sensacao'] = howAreYouFeeling?.toJson;
    data['data_envio'] = date;
    data['refeicao'] = meal?.toJson;
    data['observacoes'] = observations;
    data['b64'] = imageMeasure;
    return data;
  }
}

class MeasurementResultsModel extends ResultsModel {
  List<MeasurementModel>? results;

  MeasurementResultsModel({this.results});

  MeasurementResultsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = List<MeasurementModel>.empty(growable: true);
      json['results'].forEach(
        (v) => results!.add(MeasurementModel.fromJson(v)),
      );
    }
    previous = json['previous'];
    next = json['next'];
    offset = json['offset'];
    count = json['count'];
    pageSize = json['page_size'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results?.map((v) => v.toJson()).toList();
    data['previous'] = previous;
    data['next'] = next;
    data['offset'] = offset;
    data['count'] = count;
    data['page_size'] = pageSize;

    return data;
  }
}
