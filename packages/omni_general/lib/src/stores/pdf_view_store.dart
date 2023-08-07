import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/src/core/enums/pdf_document_type_enum.dart';
import 'package:omni_general/src/core/services/pdf_view_service.dart';
import 'package:omni_general/src/core/services/share_file_service.dart';
import 'package:omni_general/src/core/utils/path_utils.dart';

class PdfViewStore extends NotifierStore<Exception, bool> with Disposable {
  PdfViewStore() : super(false);

  Future<void> loadPDF(
    PdfViewService service,
    PDFDocumentType type, {
    String? url,
    String? asset,
    File? file,
  }) async {
    setLoading(true);
    await service
        .loadDocument(type, url: url, file: file, asset: asset)
        .then((value) {
      setLoading(false);
      update(true, force: true);
    }).catchError((onError) {
      setError(Exception(onError));
      setLoading(false);
      throw DioError(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          data: {
            'errors': {
              'Documento': 'Ocorreu um erro inesperado, '
                  'por favor contate o nosso suporte.',
            },
          },
          statusCode: 400,
        ),
        type: DioErrorType.response,
        error: '',
      );
    });
  }

  Future<void> sharePDF(
    PDFDocumentType type,
    BuildContext context, {
    String? url,
    String? asset,
    File? file,
  }) async {
    setLoading(true);
    final ShareFileService service = ShareFileService();
    switch (type) {
      case PDFDocumentType.url:
        await PathUtils().getFileFromUrl(url!).then((file) async {
          await service.file(context, file!);
        }).catchError((onError) {
          setLoading(false);
          throw Exception(onError);
        });
        break;
      case PDFDocumentType.asset:
        await PathUtils().getFileFromAssets(asset!).then((file) async {
          await service.file(context, file!);
        }).catchError((onError) {
          setLoading(false);
          throw Exception(onError);
        });
        break;
      case PDFDocumentType.file:
        await service.file(context, file!).catchError((onError) {
          setLoading(false);
          throw Exception(onError);
        });
        break;
    }
    service.dispose();
    setLoading(false);
  }

  void pdfIsLoaded(bool value) {
    update(value);
  }

  @override
  void dispose() {
    destroy();
  }
}
