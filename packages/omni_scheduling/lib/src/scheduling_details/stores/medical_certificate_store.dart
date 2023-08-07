import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/scheduling_details/scheduling_details_repository.dart';

class MedicalCertificateStore extends NotifierStore<DioError, File>
    with Disposable {
  final SchedulingDetailsRepository _repository = Modular.get();
  final PdfViewStore pdfStore = PdfViewStore();

  MedicalCertificateStore() : super(File(''));

  Future<void> getMedicalCertificateByCode(
    String code,
    PdfViewService service,
  ) async {
    setLoading(true);
    await _repository.getMedicalCertificateByCode(code).then((file) async {
      await pdfStore.loadPDF(service, PDFDocumentType.file, file: file);
      setLoading(false);
      update(file);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  @override
  void dispose() {
    _repository.dispose();
    pdfStore.dispose();
  }
}
