import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mime/mime.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/extra_documents_model.dart';
import 'package:omni_plan/src/core/models/new_reimbursement_model.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/new_reimbursement_store.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/reimbursement_step_store.dart';
import 'package:path/path.dart' show basename;
import 'package:reimbursement_labels/labels.dart';

class ReimbursementDocumentsPage extends StatefulWidget {
  final PageController controller;
  const ReimbursementDocumentsPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ReimbursementDocumentsPage> createState() =>
      _ReimbursementDocumentsPageState();
}

class _ReimbursementDocumentsPageState extends State<ReimbursementDocumentsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    newReimbursementStore.state.extraDocuments = [];
    newReimbursementStore.state.invoice = '';
    newReimbursementStore.state.receipt = '';

    newReimbursementStore.updateForm(newReimbursementStore.state);

    super.initState();
  }

  final ReimbursementStepStore reimbursementStepStore = Modular.get();
  final NewReimbursementStore newReimbursementStore = Modular.get();
  final FilePickerService service = FilePickerService();
  String? receiptName = '';
  String? invoiceName = '';
  List<String> documentsName = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    ReimbursementLabels.reimbursementDocumentsList,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                ReimbursementLabels.reimbursementDocumentsDescription,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                ReimbursementLabels.reimbursementDocumentsPaymentProof,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.error,
                    color: Colors.yellow,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    ReimbursementLabels.reimbursementDocumentsRequiredFiles,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                ReimbursementLabels.reimbursementDocumentsSuportedFiles,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(),
              _buildInvoiceWidget,
              const Divider(),
              _buildReceiptWidget,
              const Divider(),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                ReimbursementLabels.reimbursementDocumentsJustifyFiles,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 15),
              const Divider(),
              _buildExtraDocumentsAddFileWidget,
              const Divider(),
              TripleBuilder<NewReimbursementStore, DioError,
                  NewReimbursementModel>(
                store: newReimbursementStore,
                builder: (_, triple) {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        newReimbursementStore.state.extraDocuments!.length,
                    padding: EdgeInsets.zero,
                    separatorBuilder: (_, index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                    itemBuilder: (context, index) {
                      return _buildExtraDocumentsItem(
                        documentsName[index],
                        index,
                      );
                    },
                  );
                },
              ),
              if (newReimbursementStore.state.extraDocuments!.isNotEmpty)
                const Divider(),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          TripleBuilder<NewReimbursementStore, DioError, NewReimbursementModel>(
        store: newReimbursementStore,
        builder: (_, triple) {
          return BottomButtonWidget(
            isDisabled: validateDocuments(),
            onPressed: () async {
              await widget.controller.nextPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeIn,
              );
              reimbursementStepStore
                  .updateStep(widget.controller.page!.round());
            },
            text: ReimbursementLabels.reimbursementDocumentsNext,
          );
        },
      ),
    );
  }

  Widget _buildExtraDocumentsItem(String fileName, int index) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
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
                width: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  fileName,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
            ],
          ),
          GestureDetector(
            child: Icon(
              Icons.remove,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              newReimbursementStore.state.extraDocuments!.removeAt(index);
              documentsName.removeAt(index);
              newReimbursementStore.updateForm(newReimbursementStore.state);
            },
          )
        ],
      ),
    );
  }

  bool validateDocuments() {
    if (newReimbursementStore.state.invoice!.isNotEmpty ||
        newReimbursementStore.state.receipt!.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Function() receiptOnTap() {
    return newReimbursementStore.state.receipt!.isEmpty
        ? () async {
            await service.getFiles().then(
              (file) {
                if (file.isEmpty) return;
                file.forEach(
                  (file) {
                    final String ext = lookupMimeType(file.path) ?? '';
                    receiptName = basename(file.path);
                    final String base64 = UriData.fromBytes(
                      file.readAsBytesSync(),
                      mimeType: ext,
                    ).toString();

                    if (receiptName!.contains('.pdf') ||
                        receiptName!.contains('.png') ||
                        receiptName!.contains('.jpg') ||
                        receiptName!.contains('.jpeg')) {
                      newReimbursementStore.state.receipt = base64;
                      newReimbursementStore.updateForm(
                        newReimbursementStore.state,
                      );
                    } else {
                      Helpers.showDialog(
                        context,
                        RequestErrorWidget(
                          buttonText: ReimbursementLabels.close,
                          message:
                              ReimbursementLabels.reimbursementDocumentsError,
                          onPressed: () => Modular.to.pop(),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        : () {
            newReimbursementStore.state.receipt = '';
            newReimbursementStore.updateForm(
              newReimbursementStore.state,
            );
            receiptName = '';
          };
  }

  Widget get _buildReceiptWidget {
    return TripleBuilder<NewReimbursementStore, DioError,
        NewReimbursementModel>(
      store: newReimbursementStore,
      builder: (_, triple) {
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: receiptOnTap(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 50,
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              newReimbursementStore.state.receipt!.isEmpty
                                  ? ReimbursementLabels
                                      .reimbursementDocumentsReceipt
                                  : receiptName!,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        newReimbursementStore.state.receipt!.isEmpty
                            ? Icons.add
                            : Icons.close,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Function() invoiceOnTap() {
    return newReimbursementStore.state.invoice!.isEmpty
        ? () async {
            await service.getFiles().then(
              (file) {
                if (file.isEmpty) return;
                file.forEach(
                  (file) {
                    final String ext = lookupMimeType(file.path) ?? '';
                    invoiceName = basename(file.path);
                    final String base64 = UriData.fromBytes(
                      file.readAsBytesSync(),
                      mimeType: ext,
                    ).toString();

                    if (invoiceName!.contains('.pdf') ||
                        invoiceName!.contains('.png') ||
                        invoiceName!.contains('.jpg') ||
                        invoiceName!.contains('.jpeg')) {
                      newReimbursementStore.state.invoice = base64;
                      newReimbursementStore.updateForm(
                        newReimbursementStore.state,
                      );
                    } else {
                      Helpers.showDialog(
                        context,
                        RequestErrorWidget(
                          buttonText: ReimbursementLabels.close,
                          message:
                              ReimbursementLabels.reimbursementDocumentsError,
                          onPressed: () => Modular.to.pop(),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        : () {
            newReimbursementStore.state.invoice = '';
            newReimbursementStore.updateForm(
              newReimbursementStore.state,
            );
            invoiceName = '';
          };
  }

  Widget get _buildInvoiceWidget {
    return TripleBuilder<NewReimbursementStore, DioError,
        NewReimbursementModel>(
      store: newReimbursementStore,
      builder: (_, triple) {
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: invoiceOnTap(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 50,
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              newReimbursementStore.state.invoice!.isEmpty
                                  ? ReimbursementLabels
                                      .reimbursementDocumentsInvoice
                                  : invoiceName!,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        newReimbursementStore.state.invoice!.isEmpty
                            ? Icons.add
                            : Icons.close,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget get _buildExtraDocumentsAddFileWidget {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              await service.getFiles(allowMultiple: true).then(
                (file) {
                  if (file.isEmpty) return;
                  file.forEach(
                    (file) {
                      ExtraDocumentsModel doc = ExtraDocumentsModel();
                      final String ext = lookupMimeType(file.path) ?? '';
                      final name = basename(file.path);
                      final String base64 = UriData.fromBytes(
                        file.readAsBytesSync(),
                        mimeType: ext,
                      ).toString();

                      if (invoiceName!.contains('.pdf') ||
                          invoiceName!.contains('.png') ||
                          invoiceName!.contains('.jpg') ||
                          invoiceName!.contains('.jpeg')) {
                        final ExtraDocumentsModel document =
                            ExtraDocumentsModel(
                          file: base64,
                          observation: '',
                        );
                        if (newReimbursementStore
                            .state.extraDocuments!.isEmpty) {
                          documentsName.add(name);
                          newReimbursementStore.state.extraDocuments!
                              .add(document);
                          newReimbursementStore
                              .updateForm(newReimbursementStore.state);
                        } else {
                          doc = newReimbursementStore.state.extraDocuments!
                              .firstWhere(
                            (element) => element.file == base64,
                            orElse: () {
                              return ExtraDocumentsModel(file: '');
                            },
                          );
                        }
                        if (doc.file!.isEmpty) {
                          documentsName.add(name);
                          newReimbursementStore.state.extraDocuments!
                              .add(document);
                          newReimbursementStore
                              .updateForm(newReimbursementStore.state);
                        }
                      } else {
                        Helpers.showDialog(
                          context,
                          RequestErrorWidget(
                            buttonText: ReimbursementLabels.close,
                            message:
                                ReimbursementLabels.reimbursementDocumentsError,
                            onPressed: () => Modular.to.pop(),
                          ),
                        );
                      }
                    },
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
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
                        ReimbursementLabels.reimbursementDocumentsAttachFile,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
