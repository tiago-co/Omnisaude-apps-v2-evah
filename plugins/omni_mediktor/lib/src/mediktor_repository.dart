import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_mediktor/src/core/models/mediktor_diagnosis_model.dart';
import 'package:omni_mediktor/src/core/models/recomendation_model.dart';
import 'package:omni_mediktor/src/core/models/recomendation_modules_model.dart';
import 'package:omni_mediktor/src/core/models/recommended_bots_model.dart';
import 'package:omni_mediktor/src/core/models/token_mediktor_model.dart';

class MediktorRepository extends Disposable {
  final DioHttpClientImpl _client;

  MediktorRepository(this._client);

  Future<TokenMediktorModel> authenticate() async {
    try {
      final Response response = await _client.post(
        path: '/mobile/omni/login-mediktor/',
      );
      return TokenMediktorModel.fromJson(response.data);
    } on DioError catch (e) {
      log('authenticate mediktor: $e');
      rethrow;
    }
  }

  Future<RecomendationModel> sendHighUrgencyDiagnosis(
    Map diagnosis,
  ) async {
    try {
      await _client.post(
        path: '/mobile/omni/triagem-mediktor/',
        data: diagnosis,
      );
      return RecomendationModel();
    } catch (e) {
      log('sendHighUrgencyDiagnosis: $e');
      rethrow;
    }
  }

  Future<RecommendedBotsModel> getRecomendedBots(String specialtyId) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/recomendacao/$specialtyId/bot/',
      );
      return RecommendedBotsModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getRecomendedBots: $e');
      rethrow;
    }
  }

  Future<List<MediktorDiagnosisModel>> getDiagnosis() async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/sessao-mediktor/',
      );
      final List<MediktorDiagnosisModel> diagnosis = List.empty(growable: true);
      response.data.forEach((diagnose) {
        diagnosis.add(MediktorDiagnosisModel.fromJson(diagnose));
      });
      return diagnosis;
    } on DioError catch (e) {
      log('getDiagnosis: $e');
      rethrow;
    }
  }

  Future<RecomendationModulesModel> getModules(String specialtyId) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/recomendacao/$specialtyId/',
      );
      final RecomendationModulesModel modules =
          RecomendationModulesModel.fromMap(response.data);

      return modules;
    } on DioError catch (e) {
      log('getDiagnosis: $e');
      rethrow;
    }
  }

  Future<MediktorDiagnosisModel> getDiagnosisDetails(String sessionId) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/sessao-mediktor/$sessionId',
      );
      final MediktorDiagnosisModel diagnosisDeatils =
          MediktorDiagnosisModel.fromJson(response.data['session']);

      return diagnosisDeatils;
    } on DioError catch (e) {
      log('getDiagnosis: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
