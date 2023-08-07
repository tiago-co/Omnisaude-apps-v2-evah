import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/terms/pages/privacy_policies_page.dart';
import 'package:omni_core/src/app/modules/terms/pages/program_contract_page.dart';
import 'package:omni_core/src/app/modules/terms/pages/terms_of_use_page.dart';
import 'package:omni_core/src/app/modules/terms/terms_page.dart';
import 'package:omni_core/src/app/modules/terms/terms_repository.dart';
import 'package:omni_core/src/app/modules/terms/terms_store.dart';
import 'package:omni_general/omni_general.dart';

class TermsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => TermsStore()),
    Bind.lazySingleton((i) => TermsRepository(i.get<DioHttpClientImpl>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => TermsPage(programCode: args.data),
    ),
    ChildRoute(
      '/termsOfUse',
      child: (_, args) => TermOfUsePage(programCode: args.data),
    ),
    ChildRoute(
      '/privacyPolicies',
      child: (_, args) => PrivacyPoliciesPage(programCode: args.data),
    ),
    ChildRoute(
      '/programContract',
      child: (_, args) => ProgramContractPage(programCode: args.data),
    ),
  ];
}
