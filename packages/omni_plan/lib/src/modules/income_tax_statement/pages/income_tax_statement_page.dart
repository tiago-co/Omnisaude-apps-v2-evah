import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:income_tax_statement_labels/labels.dart';

import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/tax_demonstrative_model.dart';
import 'package:omni_plan/src/modules/income_tax_statement/pages/widgets/income_tax_details_field_shimmer_widget.dart';
import 'package:omni_plan/src/modules/income_tax_statement/pages/widgets/income_tax_item_textfield.dart';
import 'package:omni_plan/src/modules/income_tax_statement/stores/income_tax_pdf_store.dart';
import 'package:omni_plan/src/modules/income_tax_statement/stores/income_tax_statement_store.dart';

class IncomeTaxStatementPage extends StatefulWidget {
  final String moduleName;

  const IncomeTaxStatementPage({
    Key? key,
    required this.moduleName,
  }) : super(key: key);

  @override
  _IncomeTaxStatementPageState createState() => _IncomeTaxStatementPageState();
}

class _IncomeTaxStatementPageState extends State<IncomeTaxStatementPage> {
  final IncomeTaxStatementStore store = Modular.get();
  final IncomeTaxPdfStore pdfTaxStore = Modular.get();
  final PdfViewService service = PdfViewService();

  @override
  void initState() {
    store.getTaxDemonstrativeData();
    super.initState();
  }

  void _shareDocument(BuildContext context) {
    pdfTaxStore.pdfStore
        .sharePDF(PDFDocumentType.file, context, file: pdfTaxStore.state)
        .catchError((onError) {
      Helpers.showDialog(
        context,
        RequestErrorWidget(
          message: IncomeTaxStatementLabels.incomeTaxStatementError,
          buttonText: IncomeTaxStatementLabels.close,
          onPressed: () => Modular.to.pop(),
        ),
        showClose: true,
      );
    });
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
      body: TripleBuilder<IncomeTaxStatementStore, DioError,
          List<TaxDemonstrativeModel>>(
        store: store,
        builder: (_, triple) {
          if (pdfTaxStore.pdfStore.state) {
            return ClipRRect(child: service.pdfView(context));
          }
          if (store.state.isEmpty && !triple.isLoading) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: EmptyWidget(
                  message: IncomeTaxStatementLabels.incomeTaxStatementEmpty,
                  textButton: IncomeTaxStatementLabels.tryAgain,
                  onPressed: () async {
                    await store.getTaxDemonstrativeData().catchError(
                      (onError) async {
                        Helpers.showDialog(
                          context,
                          RequestErrorWidget(
                            error: onError,
                            onPressed: () => Modular.to.pop(),
                            buttonText: IncomeTaxStatementLabels.close,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          }
          if (triple.isLoading) {
            return const SchedulingDetailsFieldShimmerWidget();
          }

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await store.getTaxDemonstrativeData();
                  },
                  child: ListView.separated(
                    itemCount: store.state.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return _buildIncomeTaxExpansionTile(index);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIncomeTaxExpansionTile(int index) {
    return ExpansionTile(
      initiallyExpanded: index == 0,
      title: Text(
        store.state[index].baseYear!,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).primaryColor,
            ),
      ),
      children: [
        Column(
          children: [
            IncomeTaxItemTextField(
              textLabelField:
                  IncomeTaxStatementLabels.incomeTaxStatementProgram,
              value: store.state[index].program,
            ),
            IncomeTaxItemTextField(
              textLabelField:
                  IncomeTaxStatementLabels.incomeTaxStatementPlanValue,
              value: 'R\$ ${store.state[index].planValue!.toStringAsFixed(2)}',
            ),
            IncomeTaxItemTextField(
              textLabelField:
                  IncomeTaxStatementLabels.incomeTaxStatementCoparticipate,
              value:
                  'R\$ ${store.state[index].coparticipateValue!.toStringAsFixed(2)}',
            ),
            IncomeTaxItemTextField(
              textLabelField:
                  IncomeTaxStatementLabels.incomeTaxStatementBeneficiaryCount,
              value: store.state[index].beneficiaryCount.toString(),
            ),
            IncomeTaxItemTextField(
              textLabelField:
                  IncomeTaxStatementLabels.incomeTaxStatementDiscountValue,
              value: '${store.state[index].dicountValue!.toStringAsFixed(0)}%',
            ),
            IncomeTaxItemTextField(
              textLabelField: IncomeTaxStatementLabels.incomeTaxStatementUpdate,
              value: Formaters.dateToStringDate(
                store.state[index].lastUpdateDate!,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TripleBuilder<IncomeTaxPdfStore, DioError, File>(
                store: pdfTaxStore,
                builder: (_, triple) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await pdfTaxStore.getTaxDemonstrativePDF(
                            store.state[index].baseYear!,
                            service,
                          );
                          _shareDocument(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: !triple.isLoading,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.share,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      IncomeTaxStatementLabels
                                          .incomeTaxStatementShare,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              if (triple.isLoading)
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
