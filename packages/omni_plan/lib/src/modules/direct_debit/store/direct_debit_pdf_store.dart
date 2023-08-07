import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/direct_debit/direct_debit_repository.dart';
import 'package:omni_plan/src/modules/direct_debit/store/direct_debit_store.dart';

class DirectDebitPDFStore extends NotifierStore<Exception, File> {
  DirectDebitPDFStore() : super(File(''));
  final DirectDebitRepository _repository = Modular.get();
  final DirectDebitStore directDebitStore = Modular.get();
  final PdfViewStore pdfStore = PdfViewStore();

  Future<void> getPDFDirectDebit(
    PdfViewService service,
  ) async {
    setLoading(true);
    directDebitStore.setLoading(true);
    await _repository.getPDFDirectDebit().then(
      (file) async {
        await pdfStore.loadPDF(service, PDFDocumentType.file, file: file);
        directDebitStore.setLoading(false);
        setLoading(false);
        update(file);
      },
    ).catchError(
      (onError) {
        setLoading(false);
        directDebitStore.setLoading(false);
        directDebitStore.setError(onError);
        throw onError;
      },
    );
  }
}
