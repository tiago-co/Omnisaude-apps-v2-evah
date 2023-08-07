import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:diseases/src/core/allergy_model.dart';
import 'package:diseases/src/core/disease_results_model.dart';
import 'package:diseases/src/core/diseases_list_results_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart'
    show DioHttpClientImpl, QueryParamsModel;

import '../../core/allergies_list_results_model.dart';
import '../../core/diseases_model.dart';

class DiseasesRepository extends Disposable {
  final DioHttpClientImpl _client;

  DiseasesRepository(this._client);

  Future<void> saveAllergy(AllergyModel data) async {
    try {
      await _client.post(
          path: '/mobile/omni/alergia-beneficiario/', data: data.toJson());
    } on DioError catch (e) {
      log('saveAllergy: $e');
      rethrow;
    }
  }

  Future<void> saveDisease(DiseasesModel data) async {
    try {
      await _client.post(
          path: '/mobile/omni/doenca-beneficiario/', data: data.toJson());

      log('toaqui');
    } on DioError catch (e) {
      log('saveDisease: $e');
      rethrow;
    }
  }

  Future<void> removeDisease(String id) async {
    try {
      await _client.delete(
        path: '/mobile/omni/doenca-beneficiario/$id/',
      );
    } on DioError catch (e) {
      log('remove disease: $e');
      rethrow;
    }
  }

  Future<void> removeAllergy(String id) async {
    try {
      await _client.delete(
        path: '/mobile/omni/alergia-beneficiario/$id/',
      );
    } on DioError catch (e) {
      log('remove disease: $e');
      rethrow;
    }
  }

  Future<DiseasesBaseResults> getCidList(QueryParamsModel params) async {
    try {
      final response = await _client.get(
        path: '/cid/',
        queryParameters: params.toJson(),
      );

      return DiseasesBaseResults.fromJson(response.data);
    } on DioError catch (e) {
      log('verifyUser: $e');
      rethrow;
    }
  }

  Future<DiseasesListBaseResults> getDiseasesList() async {
    final QueryParamsModel params = QueryParamsModel(limit: '200');

    try {
      final response = await _client.get(
        path: '/mobile/omni/doenca-beneficiario/',
        queryParameters: params.toJson(),
      );

      return DiseasesListBaseResults.fromJson(response.data);
    } on DioError catch (e) {
      log('verifyUser: $e');
      rethrow;
    }
  }

  Future<AllergiesListBaseResults> getAllergiesList() async {
    final QueryParamsModel params = QueryParamsModel(limit: '200');

    try {
      final response = await _client.get(
        path: '/mobile/omni/alergia-beneficiario/',
        queryParameters: params.toJson(),
      );

      return AllergiesListBaseResults.fromJson(response.data);
    } on DioError catch (e) {
      log('verifyUser: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
