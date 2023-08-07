import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/coparticipation_extract_repository.dart';

class ExtractPdfStore extends NotifierStore<DioError, File> {
  ExtractPdfStore() : super(File(''));

  final CoparticipationExtractRepository _repository = Modular.get();
  final PdfViewStore pdfStore = PdfViewStore();

  Future<void> getExtractPDF(
    String id,
  ) async {
    setLoading(true);
    await _repository.getExtractPDF(id).then((file) async {
      setLoading(false);
      update(file);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }
}
