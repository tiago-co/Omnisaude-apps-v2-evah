import 'package:flutter_modular/flutter_modular.dart';

import 'package:omni_core/src/app/modules/help/help_page.dart';
import 'package:omni_core/src/app/modules/help/help_store.dart';

class HelpModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HelpStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const HelpPage()),
  ];
}
