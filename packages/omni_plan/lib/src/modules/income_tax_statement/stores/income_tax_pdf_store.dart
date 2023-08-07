import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/income_tax_statement/income_tax_statement_repository.dart';

class IncomeTaxPdfStore extends NotifierStore<DioError, File> {
  IncomeTaxPdfStore() : super(File(''));

  final IncomeTaxStatementRepository _repository = Modular.get();
  final PdfViewStore pdfStore = PdfViewStore();

  Future<void> getTaxDemonstrativePDF(
    String year,
    PdfViewService service,
  ) async {
    setLoading(true);
    await _repository.getTaxDemonstrativePDF(year).then((file) async {
      await pdfStore.loadPDF(service, PDFDocumentType.file, file: file);
      setLoading(false);
      update(file);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }
}
