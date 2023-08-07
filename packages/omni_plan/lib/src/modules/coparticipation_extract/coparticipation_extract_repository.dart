import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/coparticipation_extract_model.dart';
import 'package:omni_plan/src/core/models/extract_beneficiary_model.dart';

class CoparticipationExtractRepository extends Disposable {
  late final DioHttpClientImpl _client;

  CoparticipationExtractRepository(this._client);

  Future<ExtractBeneficiaryModel> getExtractsBeneficiary(
    String dateInit,
    dateFinal,
  ) async {
    try {
      final Response response = await _client.get(
        // path:
        path: '/mobile/omni/extrato-coparticipacao-beneficiario/',
        queryParameters: {
          'data_inicio': dateInit,
          'data_fim': dateFinal,
        },
      );
      final ExtractBeneficiaryModel data =
          ExtractBeneficiaryModel.fromJson(response.data);
      return data;
    } on DioError catch (e) {
      log('Get CoparticipationExtract: $e');
      rethrow;
    }
  }

  Future<CoparticipationExtractModel> getItemExtract(String idExtract) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/extrato-coparticipacao-beneficiario/$idExtract',
      );
      final CoparticipationExtractModel data =
          CoparticipationExtractModel.fromJson(response.data);
      return data;
    } on DioError catch (e) {
      log('Get ItemExtract: $e');
      rethrow;
    }
  }

  Future<File> getExtractPDF(String idExtract) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/extrato-coparticipacao-beneficiario-pdf/$idExtract',
      );
      final String filename = response.data['nome'];
      final bytes = base64Decode(response.data['base_64'].replaceAll('\n', ''));
      final file = File('${await PathUtils().localPath}/$filename');
      await file.writeAsBytes(bytes.buffer.asUint8List());
      return file.writeAsBytes(bytes.buffer.asUint8List());
    } on DioError catch (e) {
      log('Get ExtractPDF: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
