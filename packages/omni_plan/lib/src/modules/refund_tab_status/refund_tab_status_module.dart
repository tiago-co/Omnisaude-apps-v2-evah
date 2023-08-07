import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/modules/refund_tab_status/pages/refund_request_items_page.dart';
import 'package:omni_plan/src/modules/refund_tab_status/pages/refund_request_page.dart';
import 'package:omni_plan/src/modules/refund_tab_status/refund_tab_status_repository.dart';
import 'package:omni_plan/src/modules/refund_tab_status/stores/refund_request_date_filter_store.dart';
import 'package:omni_plan/src/modules/refund_tab_status/stores/refund_request_items_store.dart';
import 'package:omni_plan/src/modules/refund_tab_status/stores/refund_request_status_filter_store.dart';
import 'package:omni_plan/src/modules/refund_tab_status/stores/refund_request_store.dart';

class RefundTabStatusModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => RefundTabStatusRepository(i.get<DioHttpClientImpl>()),
    ),
    Bind.lazySingleton((i) => RefundRequestStore()),
    Bind.lazySingleton((i) => RefundRequestItemsStore()),
    Bind.lazySingleton((i) => RefundRequestStatusFilterStore()),
    Bind.lazySingleton((i) => RefundRequestDateFilterStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const RefundRequestPage(),
    ),
    ChildRoute(
      '/refund_request_items',
      child: (context, args) => RefundRequestItemsPage(
        refundRequest: args.data,
      ),
    ),
  ];
}
