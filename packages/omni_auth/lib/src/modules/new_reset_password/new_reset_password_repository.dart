import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/core/models/reset_password_model.dart';
import 'package:omni_general/omni_general.dart';

class NewResetPasswordRepository extends Disposable {
  late final Dio _client;
  late final DioHttpClientImpl _httpClientImpl;

  NewResetPasswordRepository() {
    _client = Dio();
    _client.options.baseUrl = dotenv.env['PRD_NEW_EVAH_API']!;
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

  Future<void> requestPasswordReset(String email) async {
    try {
      await _client.post(
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
      await _client.post(
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
