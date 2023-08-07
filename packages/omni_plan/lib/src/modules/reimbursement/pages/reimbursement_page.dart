import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/reimbursements_results_model.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/banks_list_store.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/reimbursement_step_store.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/reimbursement_store.dart';
import 'package:omni_plan/src/modules/reimbursement/widgets/reimbursement_item_widget.dart';
import 'package:omni_plan/src/modules/reimbursement/widgets/reimbursement_list_shimmer_widget.dart';
import 'package:reimbursement_labels/labels.dart';

class ReimbursementPage extends StatefulWidget {
  final String moduleName;
  const ReimbursementPage({Key? key, required this.moduleName})
      : super(key: key);

  @override
  State<ReimbursementPage> createState() => _ReimbursementPageState();
}

class _ReimbursementPageState extends State<ReimbursementPage> {
  final ReimbursementStore store = Modular.get();
  final BanksListStore banksListStore = Modular.get();
  final ReimbursementStepStore reimbursementStepStore = Modular.get();

  @override
  void initState() {
    store.getReimbursements();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.moduleName).build(context) as AppBar,
      body: TripleBuilder<ReimbursementStore, DioError,
          ReimbursementListResultsModel>(
        store: store,
        builder: (context, triple) {
          if (triple.isLoading) {
            return const ReimbursementListShimmerWidget();
          }
          if (!triple.isLoading && store.state.results!.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: EmptyWidget(
                        message: ReimbursementLabels.reimbursementEmpty,
                        onPressed: () async {
                          await store.getReimbursements();
                        },
                        textButton: ReimbursementLabels.tryAgain,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
            child: RefreshIndicator(
              onRefresh: () async {
                await store.getReimbursements();
              },
              child: Column(
                children: [
                  Expanded(
                    child: Visibility(
                      visible: store.state.results!.isNotEmpty,
                      child: ListView.separated(
                        separatorBuilder: (_, index) {
                          return const SizedBox(height: 15);
                        },
                        shrinkWrap: true,
                        itemCount: store.state.results!.length,
                        itemBuilder: (context, index) {
                          return ReimbursementItemWidget(
                            model: store.state.results![index],
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: TripleBuilder<ReimbursementStore, DioError,
          ReimbursementListResultsModel>(
        store: store,
        builder: (_, triple) {
          return BottomButtonWidget(
            isDisabled: triple.isLoading,
            onPressed: () async {
              await Modular.to
                  .pushNamed(
                '/home/omniPlan/reimbursement/new_reimbursement_page',
              )
                  .then((value) async {
                await store.getReimbursements();
                reimbursementStepStore.updateStep(0);
              });
            },
            text: ReimbursementLabels.reimbursementNew,
          );
        },
      ),
    );
  }
}
