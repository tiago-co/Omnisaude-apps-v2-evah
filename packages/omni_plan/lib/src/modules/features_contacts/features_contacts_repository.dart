import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/plan_card_model.dart';

class FeaturesContactsRepository extends Disposable {
  final DioHttpClientImpl _client;

  FeaturesContactsRepository(this._client);

  Future<PlanCardModel> getPlanFeaturesContacts() async {
    try {
      final Response _response = await _client.get(
        path: '/mobile/omni/plano-caracteristicas-contatos/',
      );
      return PlanCardModel.fromJson(_response.data);
    } on DioError catch (e) {
      log('getPlanFeaturesContacts: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
