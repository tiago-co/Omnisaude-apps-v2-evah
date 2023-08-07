import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/extra_documents_model.dart';
import 'package:omni_plan/src/core/models/new_reimbursement_model.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/new_reimbursement_store.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/reimbursement_step_store.dart';
import 'package:reimbursement_labels/labels.dart';

class ReimbursementResumePage extends StatefulWidget {
  final PageController controller;
  const ReimbursementResumePage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ReimbursementResumePage> createState() =>
      _ReimbursementResumePageState();
}

class _ReimbursementResumePageState extends State<ReimbursementResumePage>
    with AutomaticKeepAliveClientMixin {
  final NewReimbursementStore newReimbursementStore = Modular.get();
  final ReimbursementStepStore reimbursementStepStore = Modular.get();

  final PdfViewService service = PdfViewService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: TripleBuilder<NewReimbursementStore, DioError,
            NewReimbursementModel>(
          store: newReimbursementStore,
          builder: (_, triplo) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ReimbursementLabels.reimbursementResumeRequest,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    ReimbursementLabels.reimbursementResumeDescription,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        ReimbursementLabels.reimbursementResumeInstructions,
                        style:
                            Theme.of(context).textTheme.titleLarge!.copyWith(),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 15),
                      Divider(
                        color: Theme.of(context).cardColor,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        ReimbursementLabels.reimbursementResumeBeneficaryData,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                newReimbursementStore.state.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    ReimbursementLabels
                                        .reimbursementResumeContact,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    newReimbursementStore.state.phone!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    ReimbursementLabels
                                        .reimbursementResumeEmail,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    newReimbursementStore.state.email!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Divider(
                        color: Theme.of(context).cardColor,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        ReimbursementLabels.reimbursementResumePaymentData,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    ReimbursementLabels.reimbursementResumeBank,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    newReimbursementStore.state.bankName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        ReimbursementLabels
                                            .reimbursementResumeAgency,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      Text(
                                        newReimbursementStore.state.agency!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Row(
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Text(
                                              ReimbursementLabels
                                                  .reimbursementResumeAccount,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                            Text(
                                              newReimbursementStore
                                                  .state.account!
                                                  .substring(
                                                0,
                                                newReimbursementStore
                                                        .state.account!.length -
                                                    1,
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                            ),
                                            Text(
                                              '-${newReimbursementStore.state.account!.substring(
                                                newReimbursementStore
                                                        .state.account!.length -
                                                    1,
                                              )}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Divider(
                        color: Theme.of(context).cardColor,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        ReimbursementLabels
                            .reimbursementResumeAttachedDocuments,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      if (newReimbursementStore.state.invoice != null &&
                          newReimbursementStore.state.invoice!.isNotEmpty)
                        Column(
                          children: [
                            const SizedBox(height: 15),
                            GestureDetector(
                              onTap: () async {
                                openPdf(newReimbursementStore.state.invoice!);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.file_copy_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Nota Fiscal',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (newReimbursementStore.state.receipt != null &&
                          newReimbursementStore.state.receipt!.isNotEmpty)
                        Column(
                          children: [
                            const SizedBox(height: 15),
                            GestureDetector(
                              onTap: () async {
                                openPdf(newReimbursementStore.state.receipt!);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.file_copy_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          ReimbursementLabels
                                              .reimbursementResumeReceipt,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (newReimbursementStore
                          .state.extraDocuments!.isNotEmpty)
                        Column(
                          children: [
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 15,
                              child: Divider(
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      if (newReimbursementStore
                          .state.extraDocuments!.isNotEmpty)
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: newReimbursementStore
                              .state.extraDocuments!.length,
                          separatorBuilder: (context, inxex) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemBuilder: (context, index) {
                            if (newReimbursementStore
                                    .state.extraDocuments![index].file !=
                                null) {
                              return _buildDocumentItem(
                                newReimbursementStore
                                    .state.extraDocuments![index],
                                index,
                              );
                            } else {
                              return Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(top: 15),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  ReimbursementLabels
                                      .reimbursementResumeNoDocument,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              );
                            }
                          },
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar:
          TripleBuilder<NewReimbursementStore, DioError, NewReimbursementModel>(
        store: newReimbursementStore,
        builder: (_, triple) {
          return BottomButtonWidget(
            isDisabled: triple.isLoading,
            isLoading: triple.isLoading,
            onPressed: () async {
              await newReimbursementStore
                  .createReimbursementSolicitation()
                  .then((value) async {
                await widget.controller.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                );
                reimbursementStepStore
                    .updateStep(widget.controller.page!.round());
              }).catchError((onError) async {
                await Helpers.showDialog(
                  context,
                  RequestErrorWidget(
                    error: onError,
                    buttonText: ReimbursementLabels.close,
                    onPressed: () {
                      Modular.to.pop();
                    },
                  ),
                );
              });
            },
            text: ReimbursementLabels.reimbursementResumeSendRequest,
          );
        },
      ),
    );
  }

  Widget _buildDocumentItem(ExtraDocumentsModel item, int index) {
    return GestureDetector(
      onTap: () async {
        openPdf(item.file!);
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.file_copy_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${ReimbursementLabels.reimbursementResumeDocumentNumber} ${index + 1}',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openPdf(String archive) async {
    if (archive.contains('image/png') ||
        archive.contains('image/jpg') ||
        archive.contains('image/jpeg')) {
      final String filename = archive.hashCode.toString();
      final String newB64 = archive.replaceAll('\n', '').split(',').last;
      final bytes = base64Decode(newB64);
      final file = File('${await PathUtils().localPath}/$filename');
      await file.writeAsBytes(bytes.buffer.asUint8List());
      Modular.to.pushNamed(
        '/home/omniPlan/reimbursement/pdf_document_page',
        arguments: {
          'imageArquive': file,
        },
      );
    } else if (archive.contains('application/pdf')) {
      const String filename = 'PDF.pdf';
      final String newB64 = archive.replaceAll('\n', '').split(',').last;
      final bytes = base64Decode(newB64);
      final file = File('${await PathUtils().localPath}/$filename');
      await file.writeAsBytes(bytes.buffer.asUint8List());
      log(' ${file.path}');
      await newReimbursementStore.pdfStore
          .loadPDF(
        service,
        PDFDocumentType.file,
        file: file,
      )
          .then(
        (value) {
          Modular.to.pushNamed(
            '/home/omniPlan/reimbursement/pdf_document_page',
            arguments: {
              'service': service,
            },
          );
        },
      );
    } else {
      Helpers.showDialog(
        context,
        RequestErrorWidget(
          buttonText: ReimbursementLabels.close,
          message: ReimbursementLabels.reimbursementResumeinvalidFormat,
          onPressed: () => Modular.to.pop(),
        ),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
