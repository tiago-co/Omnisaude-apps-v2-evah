import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/core/models/reset_password_model.dart';
import 'package:omni_general/omni_general.dart';

class ResetPasswordRepository extends Disposable {
  late final Dio _client;
  late final DioHttpClientImpl _httpClientImpl;

  ResetPasswordRepository() {
    _client = Dio();
    _client.options.baseUrl = dotenv.env['BASE_URL']! + dotenv.env['API']!;
    _client.options.connectTimeout = int.parse(dotenv.env['TIMEOUT']!);
    _client.options.headers['X-Powered-By'] = dotenv.env['POWERED_BY'];
    _client.interceptors.add(
      LogInterceptor(
        responseHeader: false,
        responseBody: true,
        error: false,
      ),
    );
    _httpClientImpl = DioHttpClientImpl(_client);
  }

  Future<void> getAccessToken(ResetPasswordModel model) async {
    try {
      await _httpClientImpl.post(
        path: '/redefinir-senha/',
        data: model.toMap(),
      );
    } on DioError catch (e) {
      log('getAccessToken: $e');
      rethrow;
    }
  }

  Future<String> validateAccessToken(ResetPasswordModel model) async {
    try {
      final response = await _httpClientImpl.post(
        path: '/validar-redefinir-senha/',
        data: model.toMap(),
      );
      return response.data['id'];
    } on DioError catch (e) {
      log('validateAccessToken: $e');
      rethrow;
    }
  }

  Future<void> resetPassword(ResetPasswordModel model) async {
    try {
      await _httpClientImpl.put(
        path: '/recuperar-senha/${model.id}/',
        data: model.toMap(),
      );
    } on DioError catch (e) {
      log('reset password: $e');
      rethrow;
    }
  }

  Future<void> requestPasswordReset(String email) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = dotenv.env['PRD_NEW_EVAH_API']!;
      await dio.post(
        '/users/send-password-reset-email',
        data: {'email': email},
      );
    } on DioError catch (e) {
      log('reset password: $e');
      rethrow;
    }
  }

  Future<void> newResetPassword(ResetPasswordModel model) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = dotenv.env['PRD_NEW_EVAH_API']!;
      await dio.post(
        '/auth/password-reset/',
        data: {
          'token': model.token,
          'uidb64': model.id,
          'password': model.password,
        },
      );
    } on DioError catch (e) {
      log('reset password: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
