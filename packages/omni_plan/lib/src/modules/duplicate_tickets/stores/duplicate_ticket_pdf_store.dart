import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/duplicate_tickets/duplicate_tickets_repository.dart';

import 'package:omni_plan/src/modules/duplicate_tickets/stores/duplicate_tickets_list_store.dart';

class DuplicateTicketPdfStore extends NotifierStore<Exception, File> {
  DuplicateTicketPdfStore() : super(File(''));
  final DuplicateTicketsRepository _repository = Modular.get();
  final DuplicateTicketsListStore duplicateTicketsListStore = Modular.get();
  final PdfViewStore pdfStore = PdfViewStore();

  Future<void> getDuplicateTicketPDF(
    String monthlyPaymentId,
    PdfViewService service,
  ) async {
    setLoading(true);
    duplicateTicketsListStore.setLoading(true);
    await _repository.getDuplicateTicketPDF(monthlyPaymentId).then(
      (file) async {
        await pdfStore.loadPDF(service, PDFDocumentType.file, file: file);
        setLoading(false);
        update(file);
      },
    ).catchError(
      (onError) {
        setLoading(false);
        duplicateTicketsListStore.setLoading(false);
        duplicateTicketsListStore.setError(onError);
        throw onError;
      },
    );
  }
}
