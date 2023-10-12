import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/terms_enum.dart';
import 'package:omni_core/src/app/modules/terms/terms_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:terms_labels/labels.dart';

class ProgramContractPage extends StatefulWidget {
  final String programCode;

  const ProgramContractPage({
    Key? key,
    required this.programCode,
  }) : super(key: key);

  @override
  _ProgramContractPageState createState() => _ProgramContractPageState();
}

class _ProgramContractPageState extends State<ProgramContractPage> {
  final TermsStore store = Modular.get();
  final PdfViewService service = PdfViewService();

  @override
  void initState() {
    store.getTerms(TermsType.programTerm, widget.programCode, service);
    super.initState();
  }

  @override
  void dispose() {
    service.dispose();
    super.dispose();
  }

  void _shareDocument(BuildContext context) {
    store.pdfStore.sharePDF(PDFDocumentType.url, context, url: store.state).catchError((onError) {
      Helpers.showDialog(
        context,
        RequestErrorWidget(
          message: TermsLabels.programContractErrorOnLoadFile,
          buttonText: TermsLabels.close,
          onPressed: () => Modular.to.pop(),
        ),
        showClose: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Modular.to.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Contrato do programa',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
      ),
      body: TripleBuilder<TermsStore, DioError, String>(
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
                        onPressed: () {
                          store.getTerms(
                            TermsType.policies,
                            widget.programCode,
                            service,
                          );
                        },
                        error: triple.error,
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
      // bottomNavigationBar: TripleBuilder<PdfViewStore, Exception, bool>(
      //   store: store.pdfStore,
      //   builder: (_, triple) {
      //     return BottomButtonWidget(
      //       onPressed: () => _shareDocument(_),
      //       buttonType: BottomButtonType.outline,
      //       isLoading: triple.isLoading,
      //       isDisabled: triple.isLoading || !triple.state,
      //       text: TermsLabels.programContractShare,
      //     );
      //   },
      // ),
    );
  }
}
