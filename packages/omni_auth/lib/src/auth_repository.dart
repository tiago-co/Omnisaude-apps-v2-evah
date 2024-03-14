import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart'
    show
        DioHttpClientImpl,
        IndividualPersonModel,
        LecuponService,
        NewBeneficiaryModel,
        NewCredentialModel,
        NewJwtModel,
        NewPreferencesModel,
        PreferencesService;

class AuthRepository extends Disposable {
  late final Dio _client;
  late final DioHttpClientImpl _httpClientImpl;
  final LecuponService lecuponService = LecuponService();

  AuthRepository() {
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

  Future<NewPreferencesModel> newAuthenticate(NewCredentialModel data) async {
    try {
      final Response responseLogin = await _client.post('/auth/token/', data: data.toJson());

      final NewJwtModel jwt = NewJwtModel.fromJson(responseLogin.data);
      final Response responseBeneficiary = await _client.get(
        '/users/${jwt.id}',
        options: Options(headers: {'Authorization': 'Bearer ${jwt.token}'}),
      );
      final NewBeneficiaryModel beneficiary = NewBeneficiaryModel();
      beneficiary.individualPerson = IndividualPersonModel.fromJson(
        responseBeneficiary.data,
      );

      final PreferencesService service = PreferencesService();
      final NewPreferencesModel preferences = await service.getUserPreferences('user');

      await lecuponService
          .lecuponAuthenticate(
        beneficiary: beneficiary,
      )
          .then((value) {
        if (value != null) {
          beneficiary.lecuponUser = value;
        }
      });
      preferences.jwt = jwt;
      preferences.user = beneficiary;

      await service.setUserPreferences(preferences);
      return preferences;
    } catch (e) {
      log('authenticate: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    // _client.clear();
  }
}
