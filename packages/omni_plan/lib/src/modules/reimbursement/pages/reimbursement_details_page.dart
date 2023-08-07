import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/extra_documents_model.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/reimbursement_details_store.dart';
import 'package:reimbursement_labels/labels.dart';

class ReimbursementDetailsPage extends StatefulWidget {
  final String id;
  const ReimbursementDetailsPage({Key? key, required this.id})
      : super(key: key);

  @override
  State<ReimbursementDetailsPage> createState() =>
      _ReimbursementDetailsPageState();
}

class _ReimbursementDetailsPageState extends State<ReimbursementDetailsPage> {
  final ReimbursementDetailsStore store = Modular.get();
  final PdfViewService service = PdfViewService();
  bool onInvoiceClicked = false;
  bool onreceiveClicked = false;

  @override
  void initState() {
    store.getReimbursementDetails(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: ReimbursementLabels.reimbursementDetailsTitle,
      ).build(context) as AppBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: TripleBuilder(
            store: store,
            builder: (context, triple) {
              if (triple.isLoading) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: const Center(
                    child: LoadingWidget(),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ReimbursementLabels.reimbursementDetailsDescription,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 15),
                  Divider(
                    color: Theme.of(context).cardColor,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    ReimbursementLabels.reimbursementDetailsBeneficiaryData,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            store.state.name ?? 'Nome não informado',
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
                                ReimbursementLabels.reimbursementDetailsContact,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                store.state.phone!,
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
                                ReimbursementLabels.reimbursementDetailsEmail,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                store.state.email!,
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
                    ReimbursementLabels.reimbursementDetailsPaymentData,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.05),
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
                                ReimbursementLabels.reimbursementDetailsBank,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                store.state.bank!.name!,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    ReimbursementLabels
                                        .reimbursementDetailsAgency,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    store.state.agency!,
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
                                              .reimbursementDetailsAccount,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        Text(
                                          store.state.account!.substring(
                                            0,
                                            store.state.account!.length - 1,
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
                                          '-${store.state.account!.substring(
                                            store.state.account!.length - 1,
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
                    ReimbursementLabels.reimbursementDetailsAttachedDocuments,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (store.state.invoice != null)
                    Column(
                      children: [
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () async {
                            onreceiveClicked = false;
                            onInvoiceClicked = true;
                            openPdf(store.state.invoice!);
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
                                      ReimbursementLabels
                                          .reimbursementDetailsInvoice,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                    ),
                                  ],
                                ),
                                TripleBuilder<PdfViewStore, Exception, bool>(
                                  store: store.pdfStore,
                                  builder: (_, triple) {
                                    if (triple.isLoading && onInvoiceClicked) {
                                      return SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      );
                                    }
                                    return Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      color: Theme.of(context).primaryColor,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (store.state.receipt != null)
                    Column(
                      children: [
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () async {
                            onInvoiceClicked = false;
                            onreceiveClicked = true;
                            openPdf(store.state.receipt!);
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
                                      ReimbursementLabels
                                          .reimbursementDetailsReceive,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                    ),
                                  ],
                                ),
                                TripleBuilder<PdfViewStore, Exception, bool>(
                                  store: store.pdfStore,
                                  builder: (_, triple) {
                                    if (triple.isLoading && onreceiveClicked) {
                                      return SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      );
                                    }
                                    return Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      color: Theme.of(context).primaryColor,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Divider(
                          color: Theme.of(context).cardColor,
                        ),
                      ],
                    ),
                  if (store.state.extraDocuments!.isNotEmpty)
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: store.state.extraDocuments!.length,
                      separatorBuilder: (context, inxex) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        if (store.state.extraDocuments![index].file != null) {
                          return _buildDocumentItem(
                            store.state.extraDocuments![index],
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
                                  .reimbursementDetailsNoDocument,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          );
                        }
                      },
                    ),
                ],
              );
            },
          ),
        ),
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
                  '${ReimbursementLabels.reimbursementDetailsDocumentNumber} ${index + 1}',
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

  Future<void> openPdf(String url) async {
    if (url.contains('.png') || url.contains('.jpg') || url.contains('.jpeg')) {
      Modular.to.pushNamed(
        '/home/omniPlan/reimbursement/pdf_document_page',
        arguments: {
          'url': url,
        },
      );
    } else {
      await store.pdfStore
          .loadPDF(
        service,
        PDFDocumentType.url,
        url: url,
      )
          .then(
        (value) {
          onInvoiceClicked = false;
          onreceiveClicked = false;
          Modular.to.pushNamed(
            '/home/omniPlan/reimbursement/pdf_document_page',
            arguments: {
              'service': service,
              'url': url,
            },
          );
        },
      ).catchError(
        (error) {
          Helpers.showDialog(
            context,
            RequestErrorWidget(
              buttonText: ReimbursementLabels.close,
              message: ReimbursementLabels.reimbursementDetailsCantOpenDocument,
              onPressed: () => Modular.to.pop(),
            ),
          );
        },
      );
    }
  }
}
