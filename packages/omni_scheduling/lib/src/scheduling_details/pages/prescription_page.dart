import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/prescription_store.dart';
import 'package:omni_scheduling_labels/labels.dart';

class PrescriptionPage extends StatefulWidget {
  final String prescriptionId;

  const PrescriptionPage({
    Key? key,
    required this.prescriptionId,
  }) : super(key: key);

  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  final PrescriptionStore store = Modular.get();
  final PdfViewService service = PdfViewService();

  @override
  void initState() {
    store.getPrescriptionById(widget.prescriptionId, service);
    super.initState();
  }

  @override
  void dispose() {
    service.dispose();
    super.dispose();
  }

  void _shareDocument(BuildContext context) {
    store.pdfStore
        .sharePDF(PDFDocumentType.url, context, url: store.state)
        .catchError((onError) {
      Helpers.showDialog(
        context,
        RequestErrorWidget(
          message: SchedulingLabels.prescriptionError,
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
        title: SchedulingLabels.prescriptionTitle,
      ).build(context) as AppBar,
      body: TripleBuilder<PrescriptionStore, DioError, String>(
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
                          store.getPrescriptionById(
                            widget.prescriptionId,
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
            text: SchedulingLabels.prescriptionShare,
          );
        },
      ),
    );
  }
}
