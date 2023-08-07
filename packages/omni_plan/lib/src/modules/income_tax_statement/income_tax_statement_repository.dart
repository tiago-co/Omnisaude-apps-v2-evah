import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart'
    show DioHttpClientImpl, PathUtils, QueryParamsModel;
import 'package:omni_plan/src/core/models/tax_demonstrative_model.dart';

class IncomeTaxStatementRepository extends Disposable {
  final DioHttpClientImpl _client;

  IncomeTaxStatementRepository(this._client);

  Future<List<TaxDemonstrativeModel>> getTaxDemonstrativeData() async {
    final Response response = await _client.get(
      path: '/mobile/omni/demonstrativo-ir-beneficiario/',
    );
    final List<TaxDemonstrativeModel> demonstrativeList =
        List.empty(growable: true);
    // ignore: avoid_dynamic_calls
    response.data.forEach((element) {
      demonstrativeList.add(TaxDemonstrativeModel.fromMap(element));
    });

    return demonstrativeList;
  }

  Future<File> getTaxDemonstrativePDF(String year) async {
    final QueryParamsModel params = QueryParamsModel(year: year);
    final Response response = await _client.get(
      path: '/mobile/omni/demonstrativo-ir-beneficiario-pdf/',
      // savePath: '${await PathUtils().localPath}/demonstrative_IR_file.pdf',
      queryParameters: params.toJson(),
    );
    final String filename = response.data['nome'];

    final bytes = base64Decode(response.data['base_64'].replaceAll('\n', ''));

    final file = File('${await PathUtils().localPath}/$filename');

    await file.writeAsBytes(bytes.buffer.asUint8List());

    // final fileDownloaded = File('${await PathUtils().localPath}/$filename')
    //     .openSync(mode: FileMode.write);

    // fileDownloaded.writeFromSync(bytes.buffer.asUint8List());

    // fileDownloaded.close();

    return file.writeAsBytes(bytes.buffer.asUint8List());
  }

  @override
  void dispose() {}
}
