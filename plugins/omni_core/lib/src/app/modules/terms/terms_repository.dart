import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';

class TermsRepository extends Disposable {
  final DioHttpClientImpl _client;

  TermsRepository(this._client);

  Future<Map<String, dynamic>> getTerms(Map<String, dynamic> params) async {
    try {
      final Response _response = await _client.get(
        path: '/termos/',
        queryParameters: params,
      );
      return _response.data;
    } on DioError catch (e) {
      log('getVaccine: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
