import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/enums/reimbursement_type_enum.dart';
import 'package:omni_plan/src/core/models/new_reimbursement_model.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/new_reimbursement_store.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/reimbursement_step_store.dart';
import 'package:reimbursement_labels/labels.dart';

class ReimbursementTypePage extends StatefulWidget {
  final PageController controller;
  const ReimbursementTypePage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ReimbursementTypePage> createState() => _ReimbursementTypePageState();
}

class _ReimbursementTypePageState extends State<ReimbursementTypePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    newReimbursementStore.state.type = null;
    newReimbursementStore.updateForm(newReimbursementStore.state);
  }

  final ReimbursementStepStore reimbursementStepStore = Modular.get();
  final NewReimbursementStore newReimbursementStore = Modular.get();

  final TextEditingController reimbursementTypeController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ReimbursementLabels.reimbursementTypeService,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Divider(
                color: Theme.of(context).cardColor,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                ReimbursementLabels.reimbursementTypeDescription,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              SelectFieldWidget<ReimbursementType>(
                label: ReimbursementLabels.reimbursementTypeReimbursementType,
                items: ReimbursementType.values,
                controller: reimbursementTypeController,
                onSelectItem: (ReimbursementType item) {
                  newReimbursementStore.state.type = item;
                  reimbursementTypeController.text = item.label;
                  newReimbursementStore.updateForm(newReimbursementStore.state);
                },
                itemsLabels:
                    ReimbursementType.values.map((type) => type.label).toList(),
                placeholder: ReimbursementLabels
                    .reimbursementTypeReimbursementTypePlaceholder,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          TripleBuilder<NewReimbursementStore, DioError, NewReimbursementModel>(
        store: newReimbursementStore,
        builder: (_, triple) {
          return BottomButtonWidget(
            isDisabled: newReimbursementStore.state.type == null,
            onPressed: () async {
              await widget.controller.nextPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeIn,
              );
              reimbursementStepStore
                  .updateStep(widget.controller.page!.round());
            },
            text: ReimbursementLabels.reimbursementTypeNext,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
