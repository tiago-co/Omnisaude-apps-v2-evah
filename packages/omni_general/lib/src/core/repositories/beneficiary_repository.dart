import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart'
    show DioHttpClientImpl, IndividualPersonModel, PreferencesModel;
import 'package:omni_general/src/core/models/beneficiary_model.dart';
import 'package:omni_general/src/core/models/jwt_model.dart';
import 'package:omni_general/src/core/models/operator_configs_model.dart';
import 'package:omni_general/src/core/services/preferences_service.dart';

class BeneficiaryRepository extends Disposable {
  final DioHttpClientImpl _client;

  BeneficiaryRepository(this._client);

  Future<BeneficiaryModel> getBeneficiaryById(String id) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/beneficiario/$id/',
      );
      return BeneficiaryModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getBeneficiaryById: $e');
      rethrow;
    }
  }

  Future<IndividualPersonModel> getIndividualPerson(String id) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/pessoa-fisica/$id/',
      );
      return IndividualPersonModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getBeneficiaryById: $e');
      rethrow;
    }
  }

  Future<OperatorConfigsModel> getOperatorConfigs() async {
    try {
      final Response response = await _client.get(path: '/mobile/operadora/');
      return OperatorConfigsModel.fromJson(response.data);
    } catch (e) {
      log('getOperatorConfigs: $e');
      rethrow;
    }
  }

  Future<IndividualPersonModel> updateIndividualPerson(
    Map<String, dynamic> data,
    String id,
  ) async {
    try {
      final Response response = await _client.patch(
        path: '/mobile/omni/pessoa-fisica/$id/',
        data: data,
      );
      return IndividualPersonModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getBeneficiaryById: $e');
      rethrow;
    }
  }

  Future<JwtModel?> verifyToken(String userId) async {
    try {
      final PreferencesService service = PreferencesService();
      final PreferencesModel prefs = await service.getUserPreferences(userId);

      final Response response = await _client.post(
        path: '/token-verify/',
        data: {'token': prefs.jwt?.token},
      );
      return JwtModel.fromJson(response.data);
    } on DioError catch (e) {
      log('verifyToken: $e');
      rethrow;
    }
  }

  Future<JwtModel?> refreshToken(String userId, String token) async {
    try {
      final Response response = await _client.post(
        path: '/refresh-token/',
        data: {'token': token},
      );
      return JwtModel.fromJson(response.data);
    } on DioError catch (e) {
      log('refreshToken: $e');
      rethrow;
    }
  }

  Future<void> deleteUser() async {
    try {
      final Response _response = await _client.post(
        path: '/mobile/deletar-usuario/',
      );
    } on DioError catch (e) {
      log('deleteUser: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
