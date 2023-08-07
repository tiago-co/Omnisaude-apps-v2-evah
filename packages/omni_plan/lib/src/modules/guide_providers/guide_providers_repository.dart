import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart'
    show DioHttpClientImpl, QueryParamsModel;
import 'package:omni_plan/src/core/models/filter_model.dart';
import 'package:omni_plan/src/core/models/guide_providers_params_model.dart';
import 'package:omni_plan/src/core/models/plan_provider_model.dart';

class GuideRepositoryRepository extends Disposable {
  final DioHttpClientImpl _client;

  GuideRepositoryRepository(this._client);

  Future<PlanProviderResultsModel> getPlanProviders(
    GuideProvidersParamsModel params,
  ) async {
    try {
      final Response _response = await _client.get(
        path: '/mobile/omni/prestadores/',
        queryParameters: params.toJson(),
      );
      return PlanProviderResultsModel.fromJson(_response.data);
    } on DioError catch (e) {
      log('getPlanProviders: $e');
      rethrow;
    }
  }

  Future<void> setFavoriteProvider(
    PlanProviderModel model,
  ) async {
    try {
      await _client.post(
        path: '/mobile/omni/prestador-favorito/',
        data: model.toJson(),
      );
      log('deu certo');
    } on DioError catch (e) {
      log('setFavoriteProvider: $e');
      rethrow;
    }
  }

  Future<List> getProvidersSpecialty() async {
    final List listResult = [];
    final QueryParamsModel params = QueryParamsModel(limit: '100000');
    try {
      final Response _response = await _client.get(
        path: '/mobile/omni/prestador-especialidades/',
        queryParameters: params.toJson(),
      );
      FilterResultsModel.fromJson(
        _response.data,
        'especialidade',
      ).results!.forEach((element) {
        listResult.add(element.value);
      });
      return listResult;
    } on DioError catch (e) {
      log('getProvidersSpecialty: $e');
      rethrow;
    }
  }

  Future<List<String>> getProvidersAddress() async {
    final List<String> listResult = [];
    try {
      final Response _response =
          await _client.get(path: '/mobile/omni/prestador-estados/');
      FilterResultsModel.fromJson(
        _response.data,
        'estado',
      ).results!.forEach((element) {
        listResult.add(element.value!);
      });
      return listResult;
    } on DioError catch (e) {
      log('getProvidersSpecialty: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
