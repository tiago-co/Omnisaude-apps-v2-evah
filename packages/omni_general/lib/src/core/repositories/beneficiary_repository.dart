import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart'
    show DioHttpClientImpl, IndividualPersonModel, NewPreferencesModel, PreferencesModel;
import 'package:omni_general/src/core/enums/first_acess_send_to_enum.dart';
import 'package:omni_general/src/core/models/address_model.dart';
import 'package:omni_general/src/core/models/beneficiary_model.dart';
import 'package:omni_general/src/core/models/jwt_model.dart';
import 'package:omni_general/src/core/models/operator_configs_model.dart';
import 'package:omni_general/src/core/services/preferences_service.dart';

class BeneficiaryRepository extends Disposable {
  final DioHttpClientImpl _client;

  BeneficiaryRepository(this._client);

  Future<BeneficiaryModel> getBeneficiaryById(String id) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/beneficiario/$id/',
      );
      return BeneficiaryModel.oldFromJson(response.data);
    } on DioError catch (e) {
      log('getBeneficiaryById: $e');
      rethrow;
    }
  }

  Future<IndividualPersonModel> getIndividualPerson(String id) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/pessoa-fisica/$id/',
      );
      return IndividualPersonModel.oldFromJson(response.data);
    } on DioError catch (e) {
      log('getBeneficiaryById: $e');
      rethrow;
    }
  }

  Future<IndividualPersonModel> getNewIndividualPerson(String id) async {
    try {
      final PreferencesService service = PreferencesService();

      final Dio dio = Dio();
      dio.options.baseUrl = dotenv.env['PRD_NEW_EVAH_API']!;
      dio.interceptors.add(
        LogInterceptor(responseHeader: false, responseBody: true, error: false),
      );
      final NewPreferencesModel prefs = await service.getUserPreferences(id);

      final Response response = await dio.get(
        '/users/$id',
        options: Options(headers: {'Authorization': 'Bearer ${prefs.jwt?.token}'}),
      );
      return IndividualPersonModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getBeneficiaryById: $e');
      rethrow;
    }
  }

  Future<OperatorConfigsModel> getOperatorConfigs() async {
    try {
      final Response response = await _client.get(path: '/mobile/operadora/');
      return OperatorConfigsModel.fromJson(response.data);
    } catch (e) {
      log('getOperatorConfigs: $e');
      rethrow;
    }
  }

  Future<IndividualPersonModel> updateIndividualPerson(
    Map<String, dynamic> data,
    String id,
  ) async {
    try {
      final Response response = await _client.patch(
        path: '/mobile/omni/pessoa-fisica/$id/',
        data: data,
      );
      return IndividualPersonModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getBeneficiaryById: $e');
      rethrow;
    }
  }

  Future updateProfile(
    IndividualPersonModel data,
    String id,
  ) async {
    try {
      final PreferencesService service = PreferencesService();

      final Dio dio = Dio();
      dio.options.baseUrl = dotenv.env['PRD_NEW_EVAH_API']!;
      dio.interceptors.add(
        LogInterceptor(responseHeader: false, responseBody: true, error: false),
      );
      final NewPreferencesModel prefs = await service.getUserPreferences(id);

      final Response response = await dio.patch(
        '/users/$id',
        options: Options(headers: {'Authorization': 'Bearer ${prefs.jwt?.token}'}),
        data: data,
      );

      // return IndividualPersonModel.fromJson(response.data);
      return response.data;
    } on DioError catch (e) {
      log('getBeneficiaryById: $e');
      rethrow;
    }
  }

  Future<JwtModel?> verifyToken(String userId) async {
    try {
      final PreferencesService service = PreferencesService();
      final NewPreferencesModel prefs = await service.getUserPreferences(userId);

      final Response response = await _client.post(
        path: '/token-verify/',
        data: {'token': prefs.jwt?.token},
      );
      return JwtModel.fromJson(response.data);
    } on DioError catch (e) {
      log('verifyToken: $e');
      rethrow;
    }
  }

  Future<JwtModel?> refreshToken(String userId, String token) async {
    try {
      final Response response = await _client.post(
        path: '/refresh-token/',
        data: {'token': token},
      );
      return JwtModel.fromJson(response.data);
    } on DioError catch (e) {
      log('refreshToken: $e');
      rethrow;
    }
  }

  Future<IndividualPersonModel> getIndividualPersonByEmailCPF(String data, String param) async {
    try {
      final Dio dio = Dio();
      dio.options.baseUrl = dotenv.env['PRD_NEW_EVAH_API']!;
      dio.interceptors.add(
        LogInterceptor(responseHeader: false, responseBody: true, error: false),
      );

      final Response response = await dio.get('/users/', queryParameters: {param: data});
      return IndividualPersonModel.fromJson(response.data.first);
    } on DioError catch (e) {
      log('##### getIndividualPersonByEmailCPF: $e');
      rethrow;
    } catch (e) {
      log('##### getIndividualPersonByEmailCPF: $e');
      rethrow;
    }
  }

  Future sendActivationLink(FirstAcessType type, int id) async {
    try {
      final Dio dio = Dio();
      dio.options.baseUrl = dotenv.env['PRD_NEW_EVAH_API']!;
      dio.interceptors.add(
        LogInterceptor(responseHeader: false, responseBody: true, error: false),
      );

      final Response response = await dio.post(
        '/users/send-activation-link',
        data: {
          'send_to': type.name,
          'user_id': id,
        },
      );
      return response.data;
    } on DioError catch (e) {
      log('##### sendActivationLink: $e');
      rethrow;
    } catch (e) {
      log('##### sendActivationLink: $e');
      rethrow;
    }
  }

  Future<void> deleteUser() async {
    try {
      final Response _response = await _client.post(
        path: '/mobile/deletar-usuario/',
      );
    } on DioError catch (e) {
      log('deleteUser: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
