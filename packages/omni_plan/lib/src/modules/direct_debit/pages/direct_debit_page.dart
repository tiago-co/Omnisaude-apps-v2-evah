import 'package:dio/dio.dart';
import 'package:direct_debit_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/direct_debit_model.dart';
import 'package:omni_plan/src/modules/direct_debit/pages/widgets/form_direct_debit_widget.dart';
import 'package:omni_plan/src/modules/direct_debit/store/direct_debit_pdf_store.dart';
import 'package:omni_plan/src/modules/direct_debit/store/direct_debit_store.dart';

class DirectDebitPage extends StatefulWidget {
  final String moduleName;

  const DirectDebitPage({
    Key? key,
    required this.moduleName,
  }) : super(key: key);
  @override
  DirectDebitPageState createState() => DirectDebitPageState();
}

class DirectDebitPageState extends State<DirectDebitPage> {
  final DirectDebitStore store = Modular.get();
  final DirectDebitPDFStore directDebitPDFStore = Modular.get();
  final PdfViewService service = PdfViewService();

  Future<void> getDirectDebitSolicitation() async {
    await store.getDirectDebitSolicitation();
  }

  @override
  void initState() {
    getDirectDebitSolicitation();
    super.initState();
  }

  @override
  void dispose() {
    service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(
        title: widget.moduleName,
      ).build(context) as AppBar,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: TripleBuilder<DirectDebitStore, Exception, DirectDebitModel>(
          store: store,
          builder: (_, triple) {
            if (triple.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (triple.error != null) {
              return Center(
                child: RequestErrorWidget(
                  error: triple.error as DioError,
                  // message: DirectDebitLabels.directDebitError,
                  buttonText: DirectDebitLabels.directDebitBack,
                  onPressed: () {
                    Modular.to.pop();
                  },
                ),
              );
            }
            return Column(
              children: const <Widget>[
                FormDirectDebitWidget(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar:
          TripleBuilder<DirectDebitStore, Exception, DirectDebitModel>(
        store: store,
        builder: (_, button) {
          if (button.isLoading) {
            return const LoadingWidget();
          }
          return store.state.podeCadatastrarDebitoAutomatico ?? false
              ? _buildBottomButton()
              : _buildBottomButtonPDF();
        },
      ),
    );
  }

  Widget _buildBottomButtonPDF() {
    return TripleBuilder<PdfViewStore, Exception, bool>(
      store: directDebitPDFStore.pdfStore,
      builder: (_, triple) {
        return BottomButtonWidget(
          onPressed: () async {
            await directDebitPDFStore
                .getPDFDirectDebit(
              service,
            )
                .then(
              (value) async {
                Modular.to.pushNamed(
                  '/home/omniPlan/directDebit/pdf_direct_debit',
                  arguments: {
                    'service': service,
                  },
                ).then(
                  (value) {
                    store.setLoading(false);
                    directDebitPDFStore.pdfStore.setLoading(false);
                  },
                );
              },
            );
          },
          buttonType: BottomButtonType.outline,
          isLoading: triple.isLoading,
          text: DirectDebitLabels.directDebitVisualize,
        );
      },
    );
  }

  Widget _buildBottomButton() {
    return BottomButtonWidget(
      isLoading: store.isLoading,
      buttonType: BottomButtonType.outline,
      isDisabled: store.isLoading,
      text: DirectDebitLabels.directDebitRequest,
      onPressed: () async {
        await store.createRegisterDirectDebito(store.params).then(
          (value) async {
            await store.getDirectDebitSolicitation();
          },
        );
      },
    );
  }
}
