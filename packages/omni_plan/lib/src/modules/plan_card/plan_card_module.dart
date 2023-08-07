import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_plan/src/modules/plan_card/plan_card_page.dart';

import 'package:omni_plan/src/modules/plan_card/stores/plan_card_store.dart';

class PlanCardModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => PlanCardStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => PlanCardPage(moduleName: args.data['moduleName']),
    ),
  ];
}
