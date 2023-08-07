import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart'
    show BeneficiaryModel, DioHttpClientImpl, NewBeneficiaryModel;

class RegisterRepository extends Disposable {
  late final Dio _client;
  late final DioHttpClientImpl _httpClientImpl;

  RegisterRepository() {
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

  Future<NewBeneficiaryModel> verifyUser(Map<String, String> params) async {
    try {
      final Response response = await _httpClientImpl.get(
        path: '/mobile/primeiro-acesso/',
        queryParameters: params,
      );
      return NewBeneficiaryModel.fromJson(response.data);
    } on DioError catch (e) {
      log('verifyUser: $e');
      rethrow;
    }
  }

  Future<void> verifyPsp(String pspCode) async {
    try {
      await _httpClientImpl.get(
        path: '/mobile/omni/verificar-psp/',
        queryParameters: {'codigo': pspCode},
      );
    } on DioError catch (e) {
      log('verifyUser: $e');
      rethrow;
    }
  }

  Future<BeneficiaryModel> registerBeneficiary(NewBeneficiaryModel data) async {
    try {
      final Response response = await _httpClientImpl.post(
        path: '/mobile/beneficiario/',
        data: data,
      );
      return BeneficiaryModel.fromJson(response.data);
    } on DioError catch (e) {
      log('registerBeneficiary: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    _client.clear();
  }
}
