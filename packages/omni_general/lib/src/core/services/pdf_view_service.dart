import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:internet_file/internet_file.dart';
import 'package:omni_general/omni_general.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewService extends Disposable {
  late PdfController pdfController;
  final PageController pageController = PageController();

  Future<void> loadDocument(
    PDFDocumentType type, {
    String? url,
    String? asset,
    File? file,
  }) async {
    switch (type) {
      case PDFDocumentType.url:
        pdfController = PdfController(
          document: PdfDocument.openData(InternetFile.get(url!)),
        );
        break;
      case PDFDocumentType.asset:
        pdfController = PdfController(
          document: PdfDocument.openAsset(asset!),
        );
        break;
      case PDFDocumentType.file:
        pdfController = PdfController(
          document: PdfDocument.openFile(file!.path),
        );
        break;
    }
  }

  Widget pdfSinglePageView(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.1,
      child: PdfView(
        controller: pdfController,
        builders: PdfViewBuilders<DefaultBuilderOptions>(
          options: const DefaultBuilderOptions(),
          documentLoaderBuilder: (_) => const Center(child: LoadingWidget()),
          pageLoaderBuilder: (_) => const Center(child: LoadingWidget()),
          errorBuilder: (_, __) => const Center(
            child: Text('Ocorreu um erro ao carregar arquivo'),
          ),
        ),
        onDocumentError: (error) => const RequestErrorWidget(
          message: 'Ocorreu um erro ao carregar arquivo',
        ),
        scrollDirection: Axis.vertical,
      ),
    );
  }

  Widget pdfView(BuildContext context, {bool lazyLoad = false}) {
    return PdfView(
      controller: pdfController,
      builders: PdfViewBuilders<DefaultBuilderOptions>(
        options: const DefaultBuilderOptions(),
        documentLoaderBuilder: (_) => const Center(child: LoadingWidget()),
        pageLoaderBuilder: (_) => const Center(child: LoadingWidget()),
        errorBuilder: (_, __) => Center(
          child: RequestErrorWidget(
            message: 'Ocorreu um erro ao carregar arquivo',
            buttonText: 'Voltar',
            onPressed: () => Modular.to.pop(),
          ),
        ),
      ),
      onDocumentError: (error) => RequestErrorWidget(
        message: 'Ocorreu um erro ao carregar arquivo',
        buttonText: 'Voltar',
        onPressed: () => Modular.to.pop(),
      ),
      scrollDirection: Axis.vertical,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
  }
}
