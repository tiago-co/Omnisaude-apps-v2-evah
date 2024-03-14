import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/terms_enum.dart';
import 'package:omni_core/src/app/modules/terms/terms_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:terms_labels/labels.dart';

class TermOfUsePage extends StatefulWidget {
  const TermOfUsePage({
    Key? key,
  }) : super(key: key);

  @override
  _TermOfUsePageState createState() => _TermOfUsePageState();
}

class _TermOfUsePageState extends State<TermOfUsePage> {
  final TermsStore store = Modular.get();
  final PdfViewService service = PdfViewService();

  @override
  void initState() {
    store.getTerms(TermsType.terms, service);
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
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () => Modular.to.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Termos e condições de uso',
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
                  child: SingleChildScrollView(
                    clipBehavior: Clip.antiAlias,
                    physics: const BouncingScrollPhysics(),
                    child: RequestErrorWidget(
                      error: triple.error,
                    ),
                  ),
                ),
              ],
            );
          }
          return ClipRRect(child: service.pdfView(context));
        },
      ),
    );
  }
}
