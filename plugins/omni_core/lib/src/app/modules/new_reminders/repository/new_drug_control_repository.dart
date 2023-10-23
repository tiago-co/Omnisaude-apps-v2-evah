import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_caregiver/omni_caregiver.dart';
import 'package:omni_drug_control/src/core/models/drug_control_model.dart';
import 'package:omni_drug_control/src/core/models/medicine_base_model.dart';
import 'package:omni_general/omni_general.dart'
    show
        DioHttpClientImpl,
        KeyValueModel,
        KeyValueResultsModel,
        QueryParamsModel;

class NewDrugControlRepository extends Disposable {
  final DioHttpClientImpl _client;

  NewDrugControlRepository(this._client);

  Future<DrugControlModel> createDrugControl(DrugControlModel data) async {
    try {
      final Response response = await _client.post(
        path: '/mobile/omni/controle-medicamento/',
        data: data,
      );
      return DrugControlModel.fromJson(response.data);
    } on DioError catch (e) {
      log('createDrugControl: $e');
      rethrow;
    }
  }

  Future<CaregiverNotificationsModel?> updateCaregiver(
    Map<String, dynamic> data,
    String id,
  ) async {
    try {
      final Response response = await _client.patch(
        path: '/mobile/omni/cuidador-medicamento/$id/',
        data: data,
      );
      return CaregiverNotificationsModel.fromJson(response.data);
    } on DioError catch (e) {
      log('updateCaregiver: $e');
      rethrow;
    }
  }

  Future<MedicineBaseResults> getMedicines([QueryParamsModel? params]) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/base_medicamento/',
        queryParameters: params?.toJson(),
      );
      return MedicineBaseResults.fromJson(response.data);
    } on DioError catch (e) {
      log('getMedicines: $e');
      rethrow;
    }
  }

  Future<KeyValueResultsModel> getCustomMedicines([
    QueryParamsModel? params,
  ]) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/medicamento-personalizado/',
        queryParameters: params?.toJson(),
      );
      return KeyValueResultsModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getCustomMedicines: $e');
      rethrow;
    }
  }

  Future<List<KeyValueModel>?> getDosages() async {
    try {
      final Response response = await _client.get(path: '/mobile/dose/');
      return response.data
          .map<KeyValueModel>((dosage) => KeyValueModel.fromJson(dosage))
          .toList();
    } on DioError catch (e) {
      log('getDosages: $e');
      rethrow;
    }
  }

  Future<List<KeyValueModel>?> getUnities() async {
    try {
      final Response response =
          await _client.get(path: '/mobile/unidade-medida/');
      return response.data
          .map<KeyValueModel>((dosage) => KeyValueModel.fromJson(dosage))
          .toList();
    } on DioError catch (e) {
      log('getUnities: $e');
      rethrow;
    }
  }

  Future<List<KeyValueModel>?> getObservations() async {
    try {
      final Response response = await _client.get(path: '/mobile/orientacao/');
      return response.data
          .map<KeyValueModel>((dosage) => KeyValueModel.fromJson(dosage))
          .toList();
    } on DioError catch (e) {
      log('getObservations: $e');
      rethrow;
    }
  }

  Future<List<KeyValueModel>?> getAdministrations() async {
    try {
      final Response response =
          await _client.get(path: '/mobile/via-administracao/');
      return response.data
          .map<KeyValueModel>((dosage) => KeyValueModel.fromJson(dosage))
          .toList();
    } on DioError catch (e) {
      log('getAdministrations: $e');
      rethrow;
    }
  }

  Future<CaregiverResultsModel?> getCaregivers([
    QueryParamsModel? params,
  ]) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/cuidador-medicamento/',
        queryParameters: params?.toJson(),
      );
      return CaregiverResultsModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getCaregivers: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
