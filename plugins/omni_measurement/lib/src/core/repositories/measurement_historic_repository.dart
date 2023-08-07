import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';

class MeasumentHistoricRepository extends Disposable {
  final DioHttpClientImpl _client;

  MeasumentHistoricRepository(this._client);
  Future<List<int?>> getMeasurementsDays([QueryParamsModel? params]) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/dia-medicao/',
        queryParameters: params?.toJson(),
      );
      final List<int?> days = List.empty(growable: true);
      response.data.forEach(
        (day) {
          days.add(day);
        },
      );
      return days;
    } on DioError catch (e) {
      log('getMeasurementsDays: $e');
      rethrow;
    }
  }

  Future<MeasurementResultsModel> getMeasurements([
    QueryParamsModel? params,
  ]) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/medicao/',
        queryParameters: params?.toJson(),
      );
      return MeasurementResultsModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getMedicines: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
