import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/plan_card_model.dart';
import 'package:omni_plan/src/core/models/plan_token_model.dart';

class PlanCardRepository extends Disposable {
  final DioHttpClientImpl _client;

  PlanCardRepository(this._client);

  Future<PlanCardModel> getPlanCard() async {
    try {
      final Response response = await _client.get(path: '/mobile/omni/plano/');
      return PlanCardModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getPlanCard: $e');
      rethrow;
    }
  }

  Future<PlanTokenModel> getPlanToken() async {
    try {
      final Response response =
          await _client.get(path: '/mobile/omni/token-beneficiario/');
      return PlanTokenModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getPlanToken: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
