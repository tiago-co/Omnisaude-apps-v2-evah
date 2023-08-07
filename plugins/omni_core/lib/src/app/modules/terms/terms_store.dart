import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/terms_enum.dart';
import 'package:omni_core/src/app/modules/terms/terms_repository.dart';
import 'package:omni_general/omni_general.dart';

class TermsStore extends NotifierStore<DioError, String> with Disposable {
  final TermsRepository _repository = Modular.get();
  final PdfViewStore pdfStore = PdfViewStore();

  TermsStore() : super('');

  Future<void> getTerms(
    TermsType type,
    String programCode,
    PdfViewService service,
  ) async {
    setLoading(true);
    await _repository.getTerms({'programa': programCode}).then((terms) async {
      await pdfStore.loadPDF(
        service,
        PDFDocumentType.url,
        url: terms[type.toJson],
      );
      setLoading(false);
      update(terms[type.toJson]);
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
