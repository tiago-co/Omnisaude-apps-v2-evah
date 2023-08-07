import 'dart:io';

import 'package:coparticipation_extract_labels/labels.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/coparticipation_extract_model.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/pages/widget/details_item_extract_shimmer.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/pages/widget/extract_item_textfield_widget.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/stores/coparticipation_extract_store.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/stores/extract_pdf_store.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/stores/item_extract_store.dart';

class DetailsItemExtractPage extends StatefulWidget {
  final String idExtract;
  const DetailsItemExtractPage({
    Key? key,
    required this.idExtract,
  }) : super(key: key);

  @override
  State<DetailsItemExtractPage> createState() => _DetailsItemExtractState();
}

class _DetailsItemExtractState extends State<DetailsItemExtractPage> {
  CoparticipationExtractStore store = Modular.get();
  final UserStore userStore = Modular.get();

  @override
  void initState() {
    store.itemExtractStore.getItemExtract(widget.idExtract).whenComplete(() {
      store.itemExtractStore.updateState();
    });
    super.initState();
  }

  void _shareDocument(BuildContext context) {
    store.extractPdfStore.pdfStore
        .sharePDF(
      PDFDocumentType.file,
      context,
      file: store.extractPdfStore.state,
    )
        .catchError((onError) {
      Helpers.showDialog(
        context,
        RequestErrorWidget(
          message: 'Ocorreu um erro ao carregar o arquivo!',
          buttonText: 'Fechar',
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
        title: Labels.detailsItemExtractTitle,
      ).build(context) as AppBar,
      body: TripleBuilder<ItemExtractStore, DioError,
          CoparticipationExtractModel>(
        store: store.itemExtractStore,
        builder: (_, triple) {
          if (store.itemExtractStore.isLoading) {
            return const Center(
              child: DetailsItemExtractShimmer(),
            );
          } else if (triple.event == TripleEvent.error) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      physics: const BouncingScrollPhysics(),
                      child: RequestErrorWidget(
                        error: triple.error,
                        onPressed: () => store.itemExtractStore.getItemExtract(
                          widget.idExtract,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            final DateTime dateAtualizacao = Formaters.stringToDate(
              store.itemExtractStore.state.dtAtualizacao!,
            );
            final DateTime dateReferencia = Formaters.stringToDate(
              store.itemExtractStore.state.dtReferencia!,
            );
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).primaryColor.withOpacity(0.075),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Labels.detailsItemExtractCovenant,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12,
                                      ),
                                ),
                                const SizedBox(height: 10),
                                TripleBuilder<UserStore, Exception,
                                    PreferencesModel>(
                                  store: userStore,
                                  builder: (_, triple) {
                                    return Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: ImageWidget(
                                          url: triple
                                                  .state
                                                  .beneficiary!
                                                  .programSelected!
                                                  .enterprise!
                                                  .logo ??
                                              '',
                                          asset: Assets.life,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Labels.detailsItemExtractUpdateDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12,
                                      ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  Formaters.dateToStringDate(dateAtualizacao),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  Labels.detailsItemExtractEnrollment,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12,
                                      ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  store.itemExtractStore.state.cdBeneficiario!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ExtractItemTextFieldWidget(
                      textLabelField: Labels.detailsItemExtractProviderCode,
                      value: store.itemExtractStore.state.cdPrestador,
                    ),
                    ExtractItemTextFieldWidget(
                      textLabelField: Labels.detailsItemExtractProvider,
                      value: store.itemExtractStore.state.dsPrestador,
                    ),
                    ExtractItemTextFieldWidget(
                      textLabelField: Labels.detailsItemExtractItem,
                      value: store.itemExtractStore.state.dsItem,
                    ),
                    ExtractItemTextFieldWidget(
                      textLabelField: Labels.detailsItemExtractItemCode,
                      value: store.itemExtractStore.state.cdItem,
                    ),
                    ExtractItemTextFieldWidget(
                      textLabelField: Labels.detailsItemExtractReferenceDate,
                      value: Formaters.dateToStringDate(dateReferencia),
                    ),
                    ExtractItemTextFieldWidget(
                      textLabelField:
                          Labels.detailsItemExtractCoparticipationValue,
                      value:
                          'R\$ ${store.itemExtractStore.state.vlCoparticipacao!.toStringAsFixed(2)}',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TripleBuilder<ExtractPdfStore, DioError, File>(
                        store: store.extractPdfStore,
                        builder: (_, triple) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await store.extractPdfStore.getExtractPDF(
                                    widget.idExtract,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                              Labels.detailsItemExtractShare,
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
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
