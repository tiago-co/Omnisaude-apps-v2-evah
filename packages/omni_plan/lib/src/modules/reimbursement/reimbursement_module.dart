import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/reimbursement/pages/new_reimbursement_page.dart';
import 'package:omni_plan/src/modules/reimbursement/pages/reimbursement_details_page.dart';
import 'package:omni_plan/src/modules/reimbursement/pages/reimbursement_document_pdf_page.dart';
import 'package:omni_plan/src/modules/reimbursement/pages/reimbursement_page.dart';
import 'package:omni_plan/src/modules/reimbursement/reimbursement_repository.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/banks_list_store.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/new_reimbursement_store.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/reimbursement_details_store.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/reimbursement_step_store.dart';

import 'package:omni_plan/src/modules/reimbursement/stores/reimbursement_store.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/reimbursement_terms_check_store.dart';

class ReimbursementModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ReimbursementStore()),
    Bind.lazySingleton((i) => BanksListStore()),
    Bind.lazySingleton((i) => ReimbursementStepStore()),
    Bind.lazySingleton((i) => ReimbursementDetailsStore()),
    Bind.lazySingleton((i) => ReimbursermentTermsCheckStore()),
    Bind.lazySingleton((i) => NewReimbursementStore()),
    Bind.lazySingleton(
      (i) => ReimbursementRepository(i.get<DioHttpClientImpl>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => ReimbursementPage(
        moduleName: args.data['moduleName'],
      ),
    ),
    ChildRoute(
      '/reimbursement_details',
      child: (context, args) => ReimbursementDetailsPage(
        id: args.data,
      ),
    ),
    ChildRoute(
      '/new_reimbursement_page',
      child: (context, args) => const NewReimbursementPage(),
    ),
    ChildRoute(
      '/pdf_document_page',
      child: (context, args) => ReimbursementDocumentPdfPage(
        service: args.data['service'],
        url: args.data['url'],
        imageArquive: args.data['imageArquive'],
      ),
    ),
  ];
}
