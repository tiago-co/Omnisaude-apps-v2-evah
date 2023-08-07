import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/new_reimbursement_model.dart';
import 'package:omni_plan/src/modules/reimbursement/pages/reimbursement_documents_page.dart';
import 'package:omni_plan/src/modules/reimbursement/pages/reimbursement_personal_data_page.dart';
import 'package:omni_plan/src/modules/reimbursement/pages/reimbursement_resume_page.dart';
import 'package:omni_plan/src/modules/reimbursement/pages/reimbursement_success_page.dart';
import 'package:omni_plan/src/modules/reimbursement/pages/reimbursement_terms_page.dart';
import 'package:omni_plan/src/modules/reimbursement/pages/reimbursement_type_page.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/new_reimbursement_store.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/reimbursement_step_store.dart';
import 'package:omni_plan/src/modules/reimbursement/widgets/reimbursement_steps_widget.dart';
import 'package:reimbursement_labels/labels.dart';

class NewReimbursementPage extends StatefulWidget {
  const NewReimbursementPage({Key? key}) : super(key: key);

  @override
  State<NewReimbursementPage> createState() => _NewReimbursementPageState();
}

class _NewReimbursementPageState extends State<NewReimbursementPage> {
  final PageController pageController = PageController();
  final ReimbursementStepStore reimbursementStepStore = Modular.get();
  final NewReimbursementStore newReimbursementStore = Modular.get();

  @override
  void dispose() {
    newReimbursementStore.updateForm(
      NewReimbursementModel(
        name: '',
        email: '',
        phone: '',
        bank: '',
        agency: '',
        account: '',
        invoice: '',
        receipt: '',
        extraDocuments: [],
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const NavBarWidget(title: ReimbursementLabels.newReimbursementTitle)
              .build(context) as AppBar,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: TripleBuilder<ReimbursementStepStore, Exception, int>(
              store: reimbursementStepStore,
              builder: (_, triple) {
                if (reimbursementStepStore.state <= 4) {
                  return ReimbursementStepsWidget(
                    step: reimbursementStepStore.state,
                    controller: pageController,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  ReimbursementPersonalDataPage(controller: pageController),
                  ReimbursementTypePage(controller: pageController),
                  ReimbursementDocumentsPage(controller: pageController),
                  ReimbursementTermsPage(controller: pageController),
                  ReimbursementResumePage(controller: pageController),
                  const ReimbursementSuccessPage(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
