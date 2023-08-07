import 'package:duplicate_tickets_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/duplicate_tickets/stores/duplicate_ticket_pdf_store.dart';

class DuplicateTicketPdfPage extends StatefulWidget {
  final int monthlyPaymentId;
  final PdfViewService service;
  const DuplicateTicketPdfPage({
    Key? key,
    required this.monthlyPaymentId,
    required this.service,
  }) : super(key: key);

  @override
  State<DuplicateTicketPdfPage> createState() => _DuplicateTicketPdfPageState();
}

class _DuplicateTicketPdfPageState extends State<DuplicateTicketPdfPage> {
  final DuplicateTicketPdfStore store = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: DuplicateTicketsLabels.duplicateTicketPdfTitle,
      ).build(context) as AppBar,
      body: TripleBuilder<PdfViewStore, Exception, bool>(
        store: store.pdfStore,
        builder: (_, triple) {
          if (triple.isLoading && !triple.state) {
            return const LoadingWidget();
          }

          return ClipRRect(child: widget.service.pdfView(context));
        },
      ),
      bottomNavigationBar: widget.service != null
          ? TripleBuilder<PdfViewStore, Exception, bool>(
              store: store.pdfStore,
              builder: (_, triple) {
                return BottomButtonWidget(
                  onPressed: () async {
                    await store.pdfStore
                        .sharePDF(
                      PDFDocumentType.file,
                      _,
                      file: store.state,
                    )
                        .catchError(
                      (onError) {
                        Helpers.showDialog(
                          context,
                          RequestErrorWidget(
                            message:
                                DuplicateTicketsLabels.duplicateTicketPdfError,
                            buttonText: DuplicateTicketsLabels.close,
                            onPressed: () => Modular.to.pop(),
                          ),
                          showClose: true,
                        );
                      },
                    );
                  },
                  buttonType: BottomButtonType.outline,
                  isLoading: triple.isLoading,
                  isDisabled: triple.isLoading || !triple.state,
                  text: DuplicateTicketsLabels.duplicateTicketPdfShare,
                );
              },
            )
          : null,
    );
  }
}
