import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/duplicate_ticket_model.dart';

class DuplicateTicketsRepository {
  final DioHttpClientImpl _client;
  DuplicateTicketsRepository(
    this._client,
  );

  Future<List<DuplicateTicketModel>> getDuplicateTicketsList() async {
    final Response response = await _client
        .get(
      path: '/mobile/omni/segunda-via-boleto/',
    )
        .catchError(
      (onError) {
        log(onError.toString());
        throw onError;
      },
    );
    final List<DuplicateTicketModel> duplicateTicketModel =
        List.empty(growable: true);

    response.data.forEach(
      (element) {
        duplicateTicketModel.add(DuplicateTicketModel.fromMap(element));
      },
    );

    return duplicateTicketModel;
  }

  Future<File> getDuplicateTicketPDF(String monthlyPaymentId) async {
    final Response response = await _client
        .get(
      path: '/mobile/omni/segunda-via-boleto/$monthlyPaymentId',
    )
        .catchError(
      (onError) {
        log(onError.toString());
        throw onError;
      },
    );

    final bytes = base64Decode(response.data['base_64'].replaceAll('\n', ''));

    final file = File('${await PathUtils().localPath}/boleto.pdf');

    await file.writeAsBytes(bytes.buffer.asUint8List());

    return file.writeAsBytes(bytes.buffer.asUint8List());
  }
}
