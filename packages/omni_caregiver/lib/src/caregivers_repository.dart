import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_caregiver/src/core/models/caregiver_model.dart';
import 'package:omni_general/omni_general.dart'
    show DioHttpClientImpl, QueryParamsModel;

class CaregiversRepository extends Disposable {
  final DioHttpClientImpl _client;

  CaregiversRepository(this._client);

  Future<CaregiverResultsModel?> getCaregivers([
    QueryParamsModel? params,
  ]) async {
    try {
      final response = await _client.get(
        path: '/mobile/omni/cuidador-medicamento/',
        queryParameters: params?.toJson(),
      );
      return CaregiverResultsModel.fromJson(response.data);
    }on DioError catch (e) {
      log('getCaregivers: $e');
      rethrow;
    }
  }

  Future<CaregiverModel?> createCaregiver(CaregiverModel data) async {
    try {
      final response = await _client.post(
        path: '/mobile/omni/cuidador-medicamento/',
        data: data,
      );
      return CaregiverModel.fromJson(response.data);
    } on DioError catch (e) {
      log('createCaregiver: $e');
      rethrow;
    }
  }

  Future<CaregiverResultsModel?> getCaregiversByDrug(
    CaregiverResultsModel params,
  ) async {
    try {
      final response = await _client.get(
        path: '/mobile/omni/cuidador-controle-medicamentoso/',
        queryParameters: params.toJson(),
      );
      return CaregiverResultsModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getCaregivers: $e');
      rethrow;
    }
  }

  Future<void> removeCaregiverById(String id) async {
    try {
      await _client.delete(path: '/mobile/omni/cuidador-medicamento/$id/');
    } on DioError catch (e) {
      log('removeCaregiverById: $e');
      rethrow;
    }
  }

  Future<CaregiverModel?> updateCaregiver(
    Map<String, dynamic> data,
    String id,
  ) async {
    try {
      final response = await _client.patch(
        path: '/mobile/omni/cuidador-medicamento/$id/',
        data: data,
      );
      return CaregiverModel.fromJson(response.data);
    } on DioError catch (e) {
      log('updateCaregiver: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
