import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/duplicate_tickets/duplicate_tickets_repository.dart';
import 'package:omni_plan/src/modules/duplicate_tickets/pages/duplicate_ticket_pdf_page.dart';
import 'package:omni_plan/src/modules/duplicate_tickets/pages/duplicate_tickets_list_page.dart';
import 'package:omni_plan/src/modules/duplicate_tickets/stores/duplicate_ticket_pdf_store.dart';
import 'package:omni_plan/src/modules/duplicate_tickets/stores/duplicate_tickets_list_store.dart';

class DuplicateTicketModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DuplicateTicketsListStore()),
    Bind.lazySingleton((i) => DuplicateTicketPdfStore()),
    Bind.lazySingleton(
      (i) => DuplicateTicketsRepository(i.get<DioHttpClientImpl>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => DuplicateTicketsListPage(
        moduleName: args.data['moduleName'],
      ),
    ),
    ChildRoute(
      '/duplicateTicketPdfPage',
      child: (context, args) => DuplicateTicketPdfPage(
        monthlyPaymentId: args.data['monthlyPaymentId'],
        service: args.data['service'],
      ),
    ),
  ];
}
