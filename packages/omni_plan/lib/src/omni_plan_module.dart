import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/coparticipation_extract_module.dart';
import 'package:omni_plan/src/modules/direct_debit/direct_debit_module.dart';
import 'package:omni_plan/src/modules/duplicate_tickets/duplicate_tickets_module.dart';
import 'package:omni_plan/src/modules/features_contacts/features_contacts_module.dart';
import 'package:omni_plan/src/modules/guide_providers/guide_providers_module.dart';
import 'package:omni_plan/src/modules/guide_providers/stores/selected_filter.dart';
import 'package:omni_plan/src/modules/income_tax_statement/income_tax_statement_module.dart';
import 'package:omni_plan/src/modules/plan_card/plan_card_module.dart';
import 'package:omni_plan/src/modules/plan_card/plan_card_repository.dart';
import 'package:omni_plan/src/modules/plan_card/stores/plan_modules_store.dart';
import 'package:omni_plan/src/modules/plan_card/stores/plan_token_store.dart';
import 'package:omni_plan/src/modules/plan_card/stores/time_left_store.dart';
import 'package:omni_plan/src/modules/refund_tab_status/refund_tab_status_module.dart';
import 'package:omni_plan/src/modules/reimbursement/reimbursement_module.dart';

class OmniPlanModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => PlanCardRepository(i.get<DioHttpClientImpl>())),
    Bind.factory((i) => SelectedFilterStore()),
    Bind.factory((i) => PlanTokenStore()),
    Bind.factory((i) => TimeLeftStore()),
    Bind.lazySingleton((i) => PlanModulesStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/planCard', module: PlanCardModule()),
    ModuleRoute('/guideProviders', module: GuideProvidersModule()),
    ModuleRoute('/featuresContacts', module: FeaturesContactsModule()),
    ModuleRoute('/incomeTaxStatement', module: IncomeTaxStatementModule()),
    ModuleRoute('/reimbursement', module: ReimbursementModule()),
    ModuleRoute('/refundTabStatus', module: RefundTabStatusModule()),
    ModuleRoute('/duplicateTickets', module: DuplicateTicketModule()),
    ModuleRoute('/directDebit', module: DirectDebitModule()),
    ModuleRoute(
      '/coparticipationExtract',
      module: CoparticipationExtractModule(),
    ),
  ];
}
