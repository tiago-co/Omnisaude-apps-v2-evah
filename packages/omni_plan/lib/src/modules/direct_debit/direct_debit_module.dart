import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/direct_debit/pages/direct_debit_page.dart';
import 'package:omni_plan/src/modules/direct_debit/pages/pdf_document_direct_debit_page.dart';
import 'package:omni_plan/src/modules/direct_debit/direct_debit_repository.dart';
import 'package:omni_plan/src/modules/direct_debit/store/direct_debit_pdf_store.dart';
import 'package:omni_plan/src/modules/direct_debit/store/direct_debit_store.dart';
import 'package:omni_plan/src/modules/reimbursement/reimbursement_repository.dart';
import 'package:omni_plan/src/modules/reimbursement/stores/banks_list_store.dart';

class DirectDebitModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DirectDebitStore()),
    Bind.lazySingleton(
      (i) => ReimbursementRepository(i.get<DioHttpClientImpl>()),
    ),
    Bind.lazySingleton(
      (i) => DirectDebitRepository(i.get<DioHttpClientImpl>()),
    ),
    Bind.lazySingleton((i) => BanksListStore()),
    Bind.lazySingleton((i) => DirectDebitPDFStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => DirectDebitPage(
        moduleName: args.data['moduleName'],
      ),
    ),
    ChildRoute(
      '/pdf_direct_debit',
      child: (_, args) => PDFDocumentDirectDebitPage(
        service: args.data['service'],
      ),
    ),
  ];
}
