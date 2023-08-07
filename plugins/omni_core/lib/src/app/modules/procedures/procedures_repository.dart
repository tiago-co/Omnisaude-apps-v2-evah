import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/core/models/procedure_model.dart';
import 'package:omni_core/src/app/core/models/procedure_params_model.dart';
import 'package:omni_general/omni_general.dart';

class ProceduresRepository extends Disposable {
  final DioHttpClientImpl _client;

  ProceduresRepository(this._client);

  Future<ProcedureResultsModel> getProcedures([
    ProcedureParamsModel? params,
  ]) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/procedimento/',
        queryParameters: params?.toJson(),
      );
      return ProcedureResultsModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getProcedures: $e');
      rethrow;
    }
  }

  Future<ProcedureModel> getProcedureById(String id) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/procedimento/$id/',
      );
      return ProcedureModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getProcedureById: $e');
      rethrow;
    }
  }

  Future<ProcedureModel> updateProcedure(
    String id,
    Map<String, String> data,
  ) async {
    try {
      final Response response = await _client.patch(
        path: '/mobile/omni/procedimento/$id/',
        data: data,
      );
      return ProcedureModel.fromJson(response.data);
    } on DioError catch (e) {
      log('updateProcedure: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
