import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart'
    show
        BeneficiaryModel,
        DioHttpClientImpl,
        IndividualPersonModel,
        NewBeneficiaryModel,
        NewJwtModel,
        PreferencesModel,
        PreferencesService;

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

  Future createUser(String name, String email, String cpf) async {
    try {
      final Dio dio = Dio();
      dio.options.baseUrl = dotenv.env['PRD_NEW_EVAH_API']!;
      final Response responseLogin = await dio.post(
        '/users/',
        data: {
          'name': name,
          'email': email,
          'cpf': cpf,
          'client': dotenv.env['CLIENT_ID']!,
        },
      );
    } on Exception catch (e) {
      log('######## Create User: $e');
      rethrow;
    }
  }

  Future confirmUserCreate(String id, String token, String password) async {
    try {
      final Dio dio = Dio();
      dio.options.baseUrl = dotenv.env['PRD_NEW_EVAH_API']!;
      dio.interceptors.add(
        LogInterceptor(responseHeader: false, responseBody: true, error: false),
      );
      final Response responseLogin = await dio.post(
        '/users/confirm-users',
        data: {
          'uidb64': id,
          'token': token,
          'password': password,
        },
      );
      final NewJwtModel jwt = NewJwtModel.fromJson(responseLogin.data);
      // _client.options.headers['Authorization'] = 'Bearer ${jwt.token}';
      // final PreferencesService service = PreferencesService();
      // final PreferencesModel preferences = await service.getUserPreferences(
      //   jwt.id!,
      // );
      // preferences.jwt = jwt;
      // await service.setUserPreferences(preferences);

      return jwt;
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future resendUserConfirmation(String email) async {
    try {
      final Dio dio = Dio();
      dio.options.baseUrl = dotenv.env['PRD_NEW_EVAH_API']!;
      final Response responseLogin = await dio.post(
        '/users/re-send-registration-email',
        data: {
          'email': email,
        },
      );
    } on DioError catch (e) {
      log('######## Resend User Confirmation: $e');
      rethrow;
    }
  }

  // Future<BeneficiaryModel> updateUser(NewBeneficiaryModel data)async{
  Future updateUser(NewBeneficiaryModel data, String token, int id) async {
    try {
      final Dio dio = Dio();
      dio.options.baseUrl = dotenv.env['PRD_NEW_EVAH_API']!;
      dio.options.headers['Authorization'] = 'Bearer $token';
      final result = await dio.patch('/users/$id', data: data.individualPerson?.toJson());
      return result.data['message'];
    } on DioError catch (e) {
      log('##### Update user: $e');
      rethrow;
    }
  }

  Future fetchUserData(String token, String id) async {
    try {
      final Dio dio = Dio();
      dio.options.baseUrl = dotenv.env['PRD_NEW_EVAH_API']!;
      dio.options.headers['Authorization'] = 'Bearer $token';
      final result = await dio.get('/users/$id');
      final user = IndividualPersonModel.fromJson(result.data);
      return user;
    } on DioError catch (e) {
      log('##### Update user: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    _client.clear();
  }
}
