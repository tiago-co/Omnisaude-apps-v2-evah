import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/informative_type_enum.dart';
import 'package:omni_core/src/app/core/models/informative_model.dart';
import 'package:omni_core/src/app/modules/informatives/informatives_repository.dart';
import 'package:omni_general/omni_general.dart';

class InformativeDetailsStore extends NotifierStore<DioError, InformativeModel>
    with Disposable {
  final InformativesRepository _repository = Modular.get();
  final PdfViewStore pdfStore = PdfViewStore();

  InformativeDetailsStore() : super(InformativeModel());

  Future<InformativeModel?> getInformativeById(
    String id,
    PdfViewService service,
  ) async {
    setLoading(true);
    await _repository.getInformativeById(id).then((informative) async {
      update(informative!);
      if (informative.type == InformativeType.pdf) {
        await pdfStore.loadPDF(
          service,
          PDFDocumentType.url,
          url: informative.url,
        );
      }
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
    return null;
  }

  @override
  void dispose() {
    _repository.dispose();
    pdfStore.dispose();
  }
}
