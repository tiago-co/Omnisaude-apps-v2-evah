import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/scheduling_details/scheduling_details_repository.dart';

class PrescriptionStore extends NotifierStore<DioError, String>
    with Disposable {
  final SchedulingDetailsRepository _repository = Modular.get();
  final PdfViewStore pdfStore = PdfViewStore();

  PrescriptionStore() : super('');

  Future<void> getPrescriptionById(String id, PdfViewService service) async {
    setLoading(true);
    await _repository.getPrescriptionById(id).then((url) async {
      await pdfStore.loadPDF(service, PDFDocumentType.url, url: url);
      setLoading(false);
      update(url);
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
