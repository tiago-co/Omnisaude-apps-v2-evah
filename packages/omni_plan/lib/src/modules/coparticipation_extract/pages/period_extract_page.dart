import 'package:coparticipation_extract_labels/labels.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/extract_beneficiary_model.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/pages/widget/extract_item_shimmer_widget.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/pages/widget/filter_period_widget.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/pages/widget/list_extract_widget.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/stores/coparticipation_extract_store.dart';

class PeriodExtractPage extends StatefulWidget {
  const PeriodExtractPage({Key? key}) : super(key: key);

  @override
  State<PeriodExtractPage> createState() => _PeriodExtractPageState();
}

class _PeriodExtractPageState extends State<PeriodExtractPage> {
  CoparticipationExtractStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: Labels.periodExtractTitle,
      ).build(context) as AppBar,
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FilterPeriodWidget(),
            Divider(
              color: Theme.of(context).cardColor.withOpacity(0.25),
              thickness: 1,
            ),
            TripleBuilder<CoparticipationExtractStore, DioError,
                ExtractBeneficiaryModel>(
              store: store,
              builder: (_, triplo) {
                if (store.isLoading) {
                  return const Expanded(
                    child: Center(
                      child: ExtractItemShimmerWidget(),
                    ),
                  );
                } else if (triplo.event == TripleEvent.error) {
                  return Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        clipBehavior: Clip.antiAlias,
                        physics: const BouncingScrollPhysics(),
                        child: RequestErrorWidget(
                          error: triplo.error,
                          onPressed: () => store.getExtractBeneficiary(),
                        ),
                      ),
                    ),
                  );
                } else {
                  if (store.state.totalValue == null) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SingleChildScrollView(
                              clipBehavior: Clip.antiAlias,
                              physics: const BouncingScrollPhysics(),
                              child: EmptyWidget(
                                message: Labels.periodExtractError,
                                textButton: Labels.tryAgain,
                                onPressed: () {
                                  store.getExtractBeneficiary();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (store.state.totalValue != null) {
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await store.getExtractBeneficiary();
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: ListExtractWidget(
                            dateExtracts: store.state.coparticipationList!,
                          ),
                        ),
                      ),
                    );
                  }
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: TripleBuilder<CoparticipationExtractStore, Exception,
          ExtractBeneficiaryModel>(
        store: store,
        builder: (_, triplo) {
          if (store.state.totalValue != null) {
            return Container(
              padding: const EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${Labels.periodExtractTotalValue}:',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  Text(
                    'R\$ ${store.state.totalValue!.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
