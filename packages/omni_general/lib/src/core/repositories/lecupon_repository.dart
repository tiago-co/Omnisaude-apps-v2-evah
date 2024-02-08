import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_general/src/core/models/new_beneficiary_model.dart';

class LecuponRepository extends Disposable {
  Map<String, dynamic> apiMobileHeaders = {};

  final String cnpj = dotenv.env['CNPJ']!;

  late final Dio _client;
  late final DioHttpClientImpl _httpClientImpl;

  LecuponRepository() {
    _client = Dio();
    _client.options.baseUrl = dotenv.env['LECUPON_BASE_URL']!;
    _client.options.headers.addAll(
      {'Api-Secret': dotenv.env['LECUPON_API_SECRET']},
    );
    _client.interceptors.add(
      LogInterceptor(
        responseHeader: false,
        responseBody: true,
        error: false,
      ),
    );
    _httpClientImpl = DioHttpClientImpl(_client);
  }

  void changeHeaders(Map<String, dynamic> headers) {
    _httpClientImpl.setHeaders(headers);
  }

  Future<void> getAdmminToken() async {
    try {
      final Response response = await _httpClientImpl.post(
        path: '/client/v2/sign_in',
        data: AdministratorCredentialsModel(
          email: dotenv.env['LECUPON_X_ClientEmployee_Email'],
          password: dotenv.env['LECUPON_ADMIN_PASSWORD'],
        ).toJson(),
      );

      final AdministratorUserModel administratorUser = AdministratorUserModel.fromJson(response.data);

      _client.options.headers.addAll(
        {
          'X-ClientEmployee-Email': dotenv.env['LECUPON_X_ClientEmployee_Email'],
          'X-ClientEmployee-Token': administratorUser.authToken,
        },
      );
    } catch (e) {
      log('authenticationToken: $e');
    }
  }

  Future<List<CupomModel>> getOrganizationCupons({
    required int organizationUid,
    required CupomParamsModel params,
  }) async {
    try {
      final Response response = await _httpClientImpl.get(
        path: '/api/v1/public_integration/organizations/$organizationUid/coupons',
        queryParameters: params.toJson(),
      );

      final List<CupomModel> cuponsList = List.empty(growable: true);

      response.data.forEach((cupom) {
        final cup = CupomModel.fromJson(cupom);
        if (cup.discount != null && cup.discount! > 0) {
          cuponsList.add(cup);
        }
      });

      return cuponsList;
    } catch (e) {
      rethrow;
    }
  }

  Future<ActivateUserModel> createAuthorizedUser({
    required ActivateUserModel activeUser,
  }) async {
    try {
      final Response response = await _httpClientImpl.post(
        path: '/businesses/$cnpj/authorized_users',
        data: activeUser.toJson(),
      );
      final ActivateUserModel activateUser = ActivateUserModel.fromJson(response.data);
      return activateUser;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DiscountCategoryModel>> getDiscountsCategories({
    required NewBeneficiaryModel beneficiary,
    required CupomParamsModel params,
  }) async {
    try {
      final List<DiscountCategoryModel> discountsCategories = List.empty(growable: true);
      _client.options.headers.addAll(
        {
          'Api-Secret': dotenv.env['LECUPON_API_SECRET'],
          'uid': beneficiary.lecuponUser!.id.toString(),
          'client': beneficiary.lecuponUser!.client,
          'access-token': beneficiary.lecuponUser!.accessToken,
        },
      );
      final Response response = await _httpClientImpl.get(
        path: '/api/v1/public_integration/categories',
        queryParameters: params.toJson(),
      );

      response.data.forEach((discountCategory) {
        discountsCategories.add(DiscountCategoryModel.fromMap(discountCategory));
      });

      return discountsCategories;
    } catch (e) {
      rethrow;
    }
  }

  Future<LecuponUserModel> registerUser({
    required ActivateUserModel activateUser,
  }) async {
    try {
      final Response response = await _httpClientImpl.post(
        path: '/client/v2/businesses/$cnpj/users',
        data: activateUser.toJson(),
      );

      final LecuponUserModel lecuponUser = LecuponUserModel.fromJson(response.data);

      return lecuponUser;
    } on DioError {
      rethrow;
    }
  }

  Future<List<OrganizationModel>> getOrganizationsList({
    required NewBeneficiaryModel beneficiary,
    required CupomParamsModel params,
  }) async {
    try {
      _client.options.headers.addAll(
        {
          'Api-Secret': dotenv.env['LECUPON_API_SECRET'],
          'uid': beneficiary.lecuponUser!.id.toString(),
          'client': beneficiary.lecuponUser!.client,
          'access-token': beneficiary.lecuponUser!.accessToken,
        },
      );

      final Response response = await _httpClientImpl.get(
        path: '/api/v1/public_integration/organizations',
        queryParameters: params.toJson(),
      );

      final List<OrganizationModel> organizationsList = List.empty(growable: true);

      response.data.forEach((organization) {
        organizationsList.add(OrganizationModel.fromJson(organization));
      });

      return organizationsList;
    } on DioError {
      rethrow;
    }
  }

  Future<String> getSmartlinkAuthenticationToken({
    required String cpf,
  }) async {
    String smartLinkToken = '';

    try {
      final Response response = await _httpClientImpl.post(
        path: '/client/v2/businesses/$cnpj/users/$cpf/smart_link',
      );

      smartLinkToken = response.data['smart_token'];
    } catch (e) {
      log(e.toString());
    }

    return smartLinkToken;
  }

  Future<LecuponUserModel> smartLinkAuthenticate({
    required String smartToken,
  }) async {
    LecuponUserModel user = LecuponUserModel();
    try {
      final Response response = await _httpClientImpl.post(
        path: '/api/v1/public_integration/auth/sign_in?smart_token=$smartToken',
      );

      user = LecuponUserModel.fromJson(response.data);
      response.headers.map.entries.forEach(
        (element) {
          if (element.key == 'access-token') {
            user.accessToken = element.value.first;
          }
          if (element.key == 'client') {
            user.client = element.value.first;
          }
        },
      );
    } catch (e) {
      log(e.toString());
    }
    return user;
  }

  Future<CupomModel> getCupomById({
    required int organizationId,
    required int couponId,
  }) async {
    try {
      final Response response = await _httpClientImpl.get(
        path: '/api/v1/public_integration/organizations/$organizationId/coupons/$couponId',
      );
      final CupomModel coupon = CupomModel.fromJson(response.data);

      return coupon;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> rescueCoupon({
    required int organizationId,
    required RescueCouponModel rescueCoupon,
  }) async {
    try {
      final Response response = await _httpClientImpl.post(
        path: '/api/v1/public_integration/organizations/$organizationId/orders',
        data: rescueCoupon.toJson(),
      );
      return response.data['number'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _client.close();
  }
}
