import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/reimbursement_details_store.dart';
import 'package:reimbursement_labels/labels.dart';

class ReimbursementDocumentPdfPage extends StatelessWidget {
  final String? url;
  final PdfViewService? service;
  final File? imageArquive;
  ReimbursementDocumentPdfPage({
    Key? key,
    this.url,
    this.service,
    this.imageArquive,
  }) : super(key: key);

  final ReimbursementDetailsStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: ReimbursementLabels.reimbursementDocumentTitle,
      ).build(context) as AppBar,
      body: TripleBuilder<PdfViewStore, Exception, bool>(
        store: store.pdfStore,
        builder: (_, triple) {
          if (triple.isLoading && !triple.state && imageArquive == null) {
            return const LoadingWidget();
          }
          if (service == null && imageArquive == null) {
            return SafeArea(
              top: false,
              right: false,
              left: false,
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Image.network(
                  url!,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: LoadingWidget(),
                    );
                  },
                  errorBuilder: (_, __, ___) => Center(
                    child: Text(
                      ReimbursementLabels.reimbursementDocumentCantLoadImage,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ),
            );
          }

          if (imageArquive != null) {
            return SafeArea(
              top: false,
              right: false,
              left: false,
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Image.file(imageArquive!),
              ),
            );
          } else {
            return ClipRRect(child: service!.pdfView(context));
          }
        },
      ),
      bottomNavigationBar: url != null && service != null
          ? TripleBuilder<PdfViewStore, Exception, bool>(
              store: store.pdfStore,
              builder: (_, triple) {
                return BottomButtonWidget(
                  onPressed: () {
                    store.pdfStore
                        .sharePDF(
                      PDFDocumentType.url,
                      _,
                      url: url,
                    )
                        .catchError(
                      (onError) {
                        Helpers.showDialog(
                          context,
                          RequestErrorWidget(
                            message: ReimbursementLabels
                                .reimbursementDocumentErrorLoadingFile,
                            buttonText: ReimbursementLabels.close,
                            onPressed: () => Modular.to.pop(),
                          ),
                          showClose: true,
                        );
                      },
                    );
                  },
                  buttonType: BottomButtonType.outline,
                  isLoading: triple.isLoading,
                  isDisabled:
                      (triple.isLoading || !triple.state) && service != null,
                  text: ReimbursementLabels.reimbursementDocumentShare,
                );
              },
            )
          : null,
    );
  }
}
