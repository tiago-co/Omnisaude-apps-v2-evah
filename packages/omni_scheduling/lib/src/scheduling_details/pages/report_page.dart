import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling_labels/labels.dart';

class ReportPage extends StatelessWidget {
  final String? url;
  final PdfViewService? service;
  final File? imageArchive;
  final PdfViewStore pdfViewStore;

  const ReportPage({
    Key? key,
    this.url,
    this.service,
    this.imageArchive,
    required this.pdfViewStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(title: SchedulingLabels.reportTitle)
          .build(context) as AppBar,
      body: TripleBuilder<PdfViewStore, Exception, bool>(
        store: pdfViewStore,
        builder: (_, triple) {
          if (triple.isLoading && !triple.state && imageArchive == null) {
            return const LoadingWidget();
          }
          if (service == null && imageArchive == null) {
            return SafeArea(
              top: false,
              right: false,
              left: false,
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Image.network(url!),
              ),
            );
          }

          if (imageArchive != null) {
            return SafeArea(
              top: false,
              right: false,
              left: false,
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Image.file(imageArchive!),
              ),
            );
          } else {
            return ClipRRect(child: service!.pdfView(context));
          }
        },
      ),
      bottomNavigationBar: url != null && service != null
          ? TripleBuilder<PdfViewStore, Exception, bool>(
              store: pdfViewStore,
              builder: (_, triple) {
                return BottomButtonWidget(
                  onPressed: () {
                    pdfViewStore
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
                            message: SchedulingLabels.reportError,
                            buttonText: SchedulingLabels.close,
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
                  text: SchedulingLabels.reportShare,
                );
              },
            )
          : null,
    );
  }
}
