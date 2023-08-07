import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/core/models/answer_dynamic_form_model.dart';
import 'package:omni_core/src/app/core/models/dynamic_form_model.dart';
import 'package:omni_general/omni_general.dart'
    show DioHttpClientImpl, QueryParamsModel;

class ExtraDataRepository extends Disposable {
  final DioHttpClientImpl _client;

  ExtraDataRepository(this._client);

  Future<DynamicFormResultsModel> getExtraData(QueryParamsModel params) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/dados-extra/',
        queryParameters: {'ocultar': true, ...params.toJson()},
      );
      return DynamicFormResultsModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getExtraDataForms: $e');
      rethrow;
    }
  }

  Future<DynamicFormModel> getExtraDataById(String id) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/dados-extra/$id/',
      );
      return DynamicFormModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getExtraDataFormById: $e');
      rethrow;
    }
  }

  Future<DynamicFormResultsModel> getAnsweredExtraData(
    QueryParamsModel params,
  ) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/resposta-dados-extra/',
        queryParameters: params.toJson(),
      );
      return DynamicFormResultsModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getExtraDataForms: $e');
      rethrow;
    }
  }

  Future<DynamicFormModel> getAnsweredExtraDataById(String id) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/resposta-dados-extra/$id/',
      );
      return DynamicFormModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getExtraDataFormById: $e');
      rethrow;
    }
  }

  Future<DynamicFormModel> answerExtraData(AnswerDynamicFormModel data) async {
    try {
      final Response response = await _client.post(
        path: '/mobile/omni/resposta-dados-extra/',
        data: data,
      );
      return DynamicFormModel.fromJson(response.data);
    } on DioError catch (e) {
      log('answerExtraData: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
