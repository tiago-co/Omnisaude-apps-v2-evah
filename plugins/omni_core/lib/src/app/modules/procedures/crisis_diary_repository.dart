import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/core/models/answer_dynamic_form_model.dart';
import 'package:omni_core/src/app/core/models/dynamic_form_model.dart';
import 'package:omni_core/src/app/core/models/procedure_model.dart';
import 'package:omni_general/omni_general.dart';

class CrisisDiaryRepository extends Disposable {
  final DioHttpClientImpl _client;

  CrisisDiaryRepository(this._client);

  Future<DynamicFormModel> getCrisisDiary() async {
    try {
      final Response response =
          await _client.get(path: '/mobile/omni/diario-crise/');
      return DynamicFormModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getCrisisDiary: $e');
      rethrow;
    }
  }

  Future<DynamicFormResultsModel> getAnsweredCrisisDiaries(
    QueryParamsModel params,
  ) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/resposta-diario-crise/',
        queryParameters: params.toJson(),
      );
      return DynamicFormResultsModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getAnsweredCrisisDiaries: $e');
      rethrow;
    }
  }

  Future<DynamicFormModel> getAnsweredCrisisDiaryById(String id) async {
    try {
      final Response response = await _client.get(path:
        '/mobile/omni/resposta-diario-crise/$id/',
      );
      return DynamicFormModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getAnsweredCrisisDiaries: $e');
      rethrow;
    }
  }

  Future<DynamicFormModel> answerCrisisDiary(
      AnswerDynamicFormModel data,) async {
    try {
      final Response response = await _client.post(path:
        '/mobile/omni/resposta-diario-crise/',
        data: data,
      );
      return DynamicFormModel.fromJson(response.data);
    } on DioError catch (e) {
      log('answerCrisisDiary: $e');
      rethrow;
    }
  }

  Future<ProcedureModel> getCrisisDiaryReport(QueryParamsModel params) async {
    try {
      final Response response = await _client.get(path:
        '/mobile/omni/relatorio-diario-crise/',
        queryParameters: params.toJson(),
      );
      return ProcedureModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getCrisisDiaryReport: $e');
      rethrow;
    }
  }

  @override
  void dispose() {

  }
}
