import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/core/models/notice_model.dart';
import 'package:omni_general/omni_general.dart';

class NotificationsRepository extends Disposable {
  final DioHttpClientImpl _client;

  NotificationsRepository(this._client);

  Future<NoticeResultsModel?> getNotices(QueryParamsModel params) async {
    try {
      final Response _response = await _client.get(path:
        '/mobile/omni/noticia/',
        queryParameters: params.toJson(),
      );
      return NoticeResultsModel.fromJson(_response.data);
    } on DioError catch (e) {
      log('getNotices: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
  }
}
