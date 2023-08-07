import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/core/models/category_informative_model.dart';
import 'package:omni_core/src/app/core/models/informative_model.dart';
import 'package:omni_core/src/app/core/models/informative_params_model.dart';
import 'package:omni_general/omni_general.dart';

class InformativesRepository extends Disposable {
  final DioHttpClientImpl _client;

  InformativesRepository(this._client);

  Future<CategoryInformativeModelResultsModel?> getCategories(
    InformativeParamsModel params,
  ) async {
    try {
      final _response = await _client.get(
        path: '/categoria/',
        queryParameters: params.toJson(),
      );
      return CategoryInformativeModelResultsModel.fromJson(_response.data);
    } on DioError catch (e) {
      log('getCategories: $e');
      rethrow;
    }
  }

  Future<MediktorInformativeResultsModel> getMediktorInformatives(
    String id,
  ) async {
    try {
      final _response =
          await _client.get(path: '/mobile/omni/recomendacao/$id/informativo/');
      return MediktorInformativeResultsModel.fromJson(_response.data);
    } on DioError catch (e) {
      log('getMediktorInformatives: $e');
      rethrow;
    }
  }

  Future<InformativeResultsModel?> getInformatives(
    InformativeParamsModel params,
  ) async {
    try {
      final _response = await _client.get(
        path: '/mobile/informativo/',
        queryParameters: params.toJson(),
      );
      return InformativeResultsModel.fromJson(_response.data);
    } on DioError catch (e) {
      log('getInformatives: $e');
      rethrow;
    }
  }

  Future<InformativeModel?> getInformativeById(String id) async {
    try {
      final _response = await _client.get(
        path: '/mobile/informativo/$id/',
      );
      return InformativeModel.fromJson(_response.data);
    } on DioError catch (e) {
      log('getInformativeById: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
