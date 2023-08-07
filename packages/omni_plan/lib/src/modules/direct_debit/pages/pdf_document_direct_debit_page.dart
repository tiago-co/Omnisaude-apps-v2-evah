import 'package:direct_debit_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/direct_debit/store/direct_debit_pdf_store.dart';

class PDFDocumentDirectDebitPage extends StatefulWidget {
  final PdfViewService service;
  const PDFDocumentDirectDebitPage({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  State<PDFDocumentDirectDebitPage> createState() =>
      _PDFDocumentDirectDebitPageState();
}

class _PDFDocumentDirectDebitPageState
    extends State<PDFDocumentDirectDebitPage> {
  final DirectDebitPDFStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: DirectDebitLabels.pdfDocumentDirectDebitTitle,
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
                                DirectDebitLabels.pdfDocumentDirectDebitError,
                            buttonText:
                                DirectDebitLabels.pdfDocumentDirectDebitClose,
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
                  text: DirectDebitLabels.pdfDocumentDirectDebitShare,
                );
              },
            )
          : null,
    );
  }
}
