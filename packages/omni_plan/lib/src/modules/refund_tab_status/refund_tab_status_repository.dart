import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/refund_request_item_model.dart';
import 'package:omni_plan/src/core/models/refund_request_model.dart';

class RefundTabStatusRepository {
  final DioHttpClientImpl _client;
  RefundTabStatusRepository(this._client);

  Future<RefundRequestResultsModel> getAllRefundRequest(
    QueryParamsModel params,
  ) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/requisicoes-beneficiario/',
        queryParameters: params.toJson(),
      );
      return RefundRequestResultsModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getAllRefaundRequest: $e');
      rethrow;
    }
  }

  Future<RefundRequestItemResultsModel> getRefundRequestItems(
    String requestSequenceNumber,
    QueryParamsModel params,
  ) async {
    try {
      final Response response = await _client.get(
        path:
            '/mobile/omni/requisicoes-beneficiario/$requestSequenceNumber/itens/',
        queryParameters: params.toJson(),
      );
      return RefundRequestItemResultsModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getAllRefaundRequest: $e');
      rethrow;
    }
  }
}
