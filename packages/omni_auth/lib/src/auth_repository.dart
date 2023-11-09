import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart'
    show
        BeneficiaryModel,
        DioHttpClientImpl,
        JwtModel,
        LecuponService,
        OperatorConfigsModel,
        PreferencesModel,
        PreferencesService;
import 'package:omni_general/src/core/models/credential_model.dart';
import 'package:omni_general/src/core/models/new_credential_model.dart';

class AuthRepository extends Disposable {
  late final Dio _client;
  late final DioHttpClientImpl _httpClientImpl;
  final LecuponService lecuponService = LecuponService();

  AuthRepository() {
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

  Future<PreferencesModel> newAuthenticate(NewCredentialModel data) async {
    try {
      //New Api

      final Dio dio = Dio();
      dio.options.baseUrl = dotenv.env['PRD_NEW_EVAH_API']!;
      dio.interceptors.add(
        LogInterceptor(responseHeader: false, responseBody: true, error: false),
      );
      final Response responseLogin = await dio.post('/auth/token/', data: data.toJson());

      // END

      final JwtModel jwt = JwtModel.fromJson(responseLogin.data);
      final Response responseBeneficiary = await _httpClientImpl.get(
        path: '/mobile/omni/beneficiario/${jwt.id}/',
        options: Options(headers: {'Authorization': 'JWT ${jwt.token}'}),
      );
      final BeneficiaryModel beneficiary = BeneficiaryModel.oldFromJson(
        responseBeneficiary.data,
      );
      final Response responseOprConfigs = await _httpClientImpl.get(
        path: '/mobile/operadora/',
      );
      final OperatorConfigsModel oprConfigs = OperatorConfigsModel.fromJson(
        responseOprConfigs.data,
      );
      final PreferencesService service = PreferencesService();
      final PreferencesModel preferences = await service.getUserPreferences(
        jwt.id!,
      );

      // final LecuponUserModel lecuponUser =
      //     await lecuponService.lecuponAuthenticate(
      //   beneficiary: beneficiary,
      // );
      await lecuponService
          .lecuponAuthenticate(
        beneficiary: beneficiary,
      )
          .then((value) {
        if (value != null) {
          beneficiary.lecuponUser = value;
        }
      });
      // beneficiary.lecuponUser = lecuponUser;

      // ATUALIZA AS PREFERENCIAS DO USUÁRIO
      preferences.jwt = jwt;
      preferences.oprConfigs = oprConfigs;
      preferences.beneficiary = beneficiary;
      beneficiary.programs?.sort((a, b) => a.name!.compareTo(b.name!));
      beneficiary.programSelected!.currentPhase?.modules?.sort(
        (a, b) => a.name!.compareTo(b.name!),
      );
      preferences.primaryColor = int.tryParse(
        '0xFF${beneficiary.programSelected!.enterprise!.primaryColor!}',
      );

      await service.setUserPreferences(preferences);
      return preferences;
    } catch (e) {
      log('authenticate: $e');
      rethrow;
    }
  }

  Future<PreferencesModel> authenticate(CredentialModel data) async {
    try {
      final Response responseLogin = await _httpClientImpl.post(path: '/login/', data: data);
      final JwtModel jwt = JwtModel.fromJson(responseLogin.data);
      final Response responseBeneficiary = await _httpClientImpl.get(
        path: '/mobile/omni/beneficiario/${jwt.id}/',
        options: Options(headers: {'Authorization': 'JWT ${jwt.token}'}),
      );
      final BeneficiaryModel beneficiary = BeneficiaryModel.fromJson(
        responseBeneficiary.data,
      );
      final Response responseOprConfigs = await _httpClientImpl.get(
        path: '/mobile/operadora/',
      );
      final OperatorConfigsModel oprConfigs = OperatorConfigsModel.fromJson(
        responseOprConfigs.data,
      );
      final PreferencesService service = PreferencesService();
      final PreferencesModel preferences = await service.getUserPreferences(
        jwt.id!,
      );

      // final LecuponUserModel lecuponUser =
      //     await lecuponService.lecuponAuthenticate(
      //   beneficiary: beneficiary,
      // );
      await lecuponService
          .lecuponAuthenticate(
        beneficiary: beneficiary,
      )
          .then((value) {
        if (value != null) {
          beneficiary.lecuponUser = value;
        }
      });
      // beneficiary.lecuponUser = lecuponUser;

      // ATUALIZA AS PREFERENCIAS DO USUÁRIO
      preferences.jwt = jwt;
      preferences.oprConfigs = oprConfigs;
      preferences.beneficiary = beneficiary;
      beneficiary.programs?.sort((a, b) => a.name!.compareTo(b.name!));
      beneficiary.programSelected!.currentPhase?.modules?.sort(
        (a, b) => a.name!.compareTo(b.name!),
      );
      preferences.primaryColor = int.tryParse(
        '0xFF${beneficiary.programSelected!.enterprise!.primaryColor!}',
      );

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
