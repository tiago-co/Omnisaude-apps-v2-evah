import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_drug_control/src/core/models/consuption_model.dart';
import 'package:omni_drug_control/src/core/models/drug_control_model.dart';
import 'package:omni_drug_control/src/core/models/medicine_model.dart';
import 'package:omni_general/omni_general.dart'
    show DioHttpClientImpl, QueryParamsModel;

class DrugControlHistoricRepository extends Disposable {
  final DioHttpClientImpl _client;

  DrugControlHistoricRepository(this._client);

  Future<DrugControlResultsModel> getDrugControls([
    QueryParamsModel? params,
  ]) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/controle-medicamento/',
        queryParameters: params?.toJson(),
      );
      return DrugControlResultsModel.fromJson(response.data);
    } catch (e) {
      log('getDrugControls: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getDrugControlsDays([
    QueryParamsModel? params,
  ]) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/dia-historico-medicamento/',
        queryParameters: params?.toJson(),
      );
      return response.data;
    } on DioError catch (e) {
      log('getDrugControlsDays: $e');
      rethrow;
    }
  }

  Future<DrugControlModel> getDrugControlById(String id) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/dia-historico-medicamento/$id/',
      );
      return DrugControlModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getDrugControlById: $e');
      rethrow;
    }
  }

  Future<MedicineResultsModel> getMedicines([QueryParamsModel? params]) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/historico-medicamento/',
        queryParameters: params?.toJson(),
      );
      return MedicineResultsModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getMedicines: $e');
      rethrow;
    }
  }

  Future<void> informConsumption(
    ConsuptionModel params,
    String id,
  ) async {
    try {
      await _client.patch(
        path: '/mobile/historico_medicamento/$id/',
        data: params.toMap(),
      );
    } on DioError catch (e) {
      log('informeConsumption: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
