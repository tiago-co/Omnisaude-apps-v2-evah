import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/medical_certificate_store.dart';
import 'package:omni_scheduling_labels/labels.dart';

class MedicalCertificatePage extends StatefulWidget {
  final String code;

  const MedicalCertificatePage({
    Key? key,
    required this.code,
  }) : super(key: key);

  @override
  _MedicalCertificatePageState createState() => _MedicalCertificatePageState();
}

class _MedicalCertificatePageState extends State<MedicalCertificatePage> {
  final MedicalCertificateStore store = Modular.get();
  final PdfViewService service = PdfViewService();

  @override
  void initState() {
    store.getMedicalCertificateByCode(widget.code, service);
    super.initState();
  }

  @override
  void dispose() {
    service.dispose();
    super.dispose();
  }

  void _shareDocument(BuildContext context) {
    store.pdfStore
        .sharePDF(PDFDocumentType.file, context, file: store.state)
        .catchError((onError) {
      Helpers.showDialog(
        context,
        RequestErrorWidget(
          message: SchedulingLabels.medicalCertificateError,
          buttonText: SchedulingLabels.close,
          onPressed: () => Modular.to.pop(),
        ),
        showClose: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: SchedulingLabels.medicalCertificateTitle,
      ).build(context) as AppBar,
      body: TripleBuilder<MedicalCertificateStore, DioError, File>(
        store: store,
        builder: (_, triple) {
          if (triple.isLoading) return const LoadingWidget();
          if (triple.event == TripleEvent.error) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      physics: const BouncingScrollPhysics(),
                      child: RequestErrorWidget(
                        error: triple.error,
                        onPressed: () {
                          store.getMedicalCertificateByCode(
                            widget.code,
                            service,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (store.pdfStore.state) {
            return ClipRRect(child: service.pdfView(context));
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: TripleBuilder<PdfViewStore, Exception, bool>(
        store: store.pdfStore,
        builder: (_, triple) {
          return BottomButtonWidget(
            onPressed: () => _shareDocument(_),
            buttonType: BottomButtonType.outline,
            isLoading: triple.isLoading,
            isDisabled: triple.isLoading || !triple.state,
            text: SchedulingLabels.medicalCertificateShare,
          );
        },
      ),
    );
  }
}
