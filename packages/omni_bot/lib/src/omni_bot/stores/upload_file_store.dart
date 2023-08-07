import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart'
    show PdfViewService, PDFDocumentType;

class UploadFileStore extends NotifierStore<Exception, bool> {
  UploadFileStore() : super(false);

  Future<void> loadPDFPreview(PdfViewService service, String url) async {
    setLoading(true);
    await service.loadDocument(PDFDocumentType.url, url: url).then((value) {
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
    });
  }
}
