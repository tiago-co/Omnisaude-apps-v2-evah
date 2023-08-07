import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';

class UtilsRepository extends Disposable {
  late final Dio _client;

  UtilsRepository() {
    _client = Dio(
      BaseOptions(connectTimeout: int.parse(dotenv.env['TIMEOUT']!)),
    )..interceptors.add(
        LogInterceptor(
          responseHeader: false,
          responseBody: true,
          error: false,
        ),
      );
  }

  Future<ViaCepModel> getAddressByCep(String zipCode) async {
    try {
      final Response response = await _client.get(
        'https://viacep.com.br/ws/$zipCode/json/',
      );
      return ViaCepModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getAddressByCep: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    // _client.clear();
  }
}
