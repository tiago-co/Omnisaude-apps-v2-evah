import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/bank_model.dart';
import 'package:omni_plan/src/core/models/direct_debit_model.dart';
import 'package:omni_plan/src/core/models/direct_debit_params_model.dart';

class DirectDebitRepository {
  final DioHttpClientImpl _client;
  DirectDebitRepository(
    this._client,
  );

  Future<BanksListResultsModel> getAvaliableBanks() async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/banco/',
      );
      return BanksListResultsModel.fromMap(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<DirectDebitModel> getDirectDebitSolicitation() async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/debito-automatico/',
      );
      return DirectDebitModel.fromMap(response.data);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<DirectDebitModel> createRegisterDirectDebito(
    DirectDebitParamsModel params,
  ) async {
    try {
      final Response response = await _client.post(
        path: '/mobile/omni/debito-automatico/',
        data: params.toJson(),
      );
      return DirectDebitModel.fromMap(response.data);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<File> getPDFDirectDebit() async {
    final Response response = await _client
        .get(
      path: '/mobile/omni/debito-automatico-pdf/',
    )
        .catchError(
      (onError) {
        log(onError.toString());
        throw onError;
      },
    );
    final bytes = base64Decode(response.data['base64'].split(',')[1]);

    final file = File(
      '${await PathUtils().localPath}/solicitacao_debito_automatico.pdf',
    );

    await file.writeAsBytes(bytes.buffer.asUint8List());

    return file.writeAsBytes(bytes.buffer.asUint8List());
  }

  void dispose() {}
}
