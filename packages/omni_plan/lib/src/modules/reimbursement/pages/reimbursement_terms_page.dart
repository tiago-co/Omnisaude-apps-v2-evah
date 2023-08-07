import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/reimbursement_step_store.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/reimbursement_terms_check_store.dart';
import 'package:reimbursement_labels/labels.dart';

class ReimbursementTermsPage extends StatefulWidget {
  final PageController controller;
  const ReimbursementTermsPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ReimbursementTermsPage> createState() => _ReimbursementTermsPageState();
}

class _ReimbursementTermsPageState extends State<ReimbursementTermsPage>
    with AutomaticKeepAliveClientMixin {
  final ReimbursementStepStore reimbursementStepStore = Modular.get();
  final ReimbursermentTermsCheckStore store = Modular.get();
  bool termsChecked = false;

  @override
  void initState() {
    store.updateValue(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    ReimbursementLabels.reimbursementTermsSaveDocuments,
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
                ReimbursementLabels.reimbursementTermsDigitalReimbursement,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                ReimbursementLabels.reimbursementTermsInstructions,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                ReimbursementLabels.reimbursementTermsAlert,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TripleBuilder<ReimbursermentTermsCheckStore, Exception, bool>(
                    store: store,
                    builder: (_, triple) {
                      return IconButton(
                        onPressed: () {
                          store.updateValue(!store.state);
                        },
                        icon: Icon(
                          store.state
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      ReimbursementLabels.reimbursementTermsAcceptTerms,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          TripleBuilder<ReimbursermentTermsCheckStore, Exception, bool>(
        store: store,
        builder: (_, triple) {
          return BottomButtonWidget(
            isDisabled: !store.state,
            onPressed: () async {
              await widget.controller.nextPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeIn,
              );
              reimbursementStepStore
                  .updateStep(widget.controller.page!.round());
            },
            text: ReimbursementLabels.reimbursementTermsNext,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
