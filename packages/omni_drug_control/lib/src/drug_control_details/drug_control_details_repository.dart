import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_drug_control/src/core/models/drug_control_model.dart';
import 'package:omni_general/omni_general.dart';

class DrugControlDetailsRepository extends Disposable {
  final DioHttpClientImpl _client;

  DrugControlDetailsRepository(this._client);

  Future<DrugControlModel> getDrugControlById(String id) async {
    final Response response = await _client.get(
      path: '/mobile/omni/controle-medicamento/$id',
    );
    return DrugControlModel.fromJson(response.data);
  }

  Future<DrugControlModel> removeDrugControlById(String id) async {
    try {
      final Response response = await _client.delete(
        path: '/mobile/omni/controle-medicamento/$id/',
      );
      return DrugControlModel.fromJson(response.data);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  void dispose() {}
}
