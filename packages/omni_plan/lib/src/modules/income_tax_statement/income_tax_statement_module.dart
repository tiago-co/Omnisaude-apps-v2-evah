import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';

import 'package:omni_plan/src/modules/income_tax_statement/income_tax_statement_repository.dart';
import 'package:omni_plan/src/modules/income_tax_statement/pages/income_tax_statement_page.dart';
import 'package:omni_plan/src/modules/income_tax_statement/stores/income_tax_pdf_store.dart';
import 'package:omni_plan/src/modules/income_tax_statement/stores/income_tax_statement_store.dart';

class IncomeTaxStatementModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => IncomeTaxStatementStore()),
    Bind.lazySingleton((i) => IncomeTaxPdfStore()),
    Bind.lazySingleton(
      (i) => IncomeTaxStatementRepository(i.get<DioHttpClientImpl>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => IncomeTaxStatementPage(
        moduleName: args.data['moduleName'],
      ),
    ),
  ];
}
