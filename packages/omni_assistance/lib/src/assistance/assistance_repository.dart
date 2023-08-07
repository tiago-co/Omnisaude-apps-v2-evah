import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_assistance/src/core/models/assistance_model.dart';
import 'package:omni_assistance/src/core/models/assistance_query_params_model.dart';
import 'package:omni_general/omni_general.dart';

class AssistanceRepository extends Disposable {
  final DioHttpClientImpl _client;

  AssistanceRepository(this._client);

  Future<AssistanceModel> createAssistance(AssistanceModel data) async {
    try {
      final response =
          await _client.post(path: '/mobile/omni/assistencia/', data: data);
      return AssistanceModel.fromJson(response.data);
    } on DioError catch (e) {
      log('createAssistance: $e');
      rethrow;
    }
  }

  Future<AssistanceModel> getAssistance(String id) async {
    try {
      final response = await _client.get(path: '/mobile/omni/assistencia/$id/');
      return AssistanceModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getAssistance: $e');
      rethrow;
    }
  }

  Future<AssistanceResultsModel> getAssistanceList(
      AssistanceQueryParamsModel params) async {
    try {
      final response = await _client.get(
        path: '/mobile/omni/assistencia/',
        queryParameters: params.toJson(),
      );
      return AssistanceResultsModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getAssistanceList: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    // _client.clear();
  }
}
