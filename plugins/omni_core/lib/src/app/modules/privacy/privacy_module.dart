import 'package:flutter_modular/flutter_modular.dart';

import 'package:omni_core/src/app/modules/privacy/privacy_page.dart';
import 'package:omni_core/src/app/modules/privacy/privacy_store.dart';

class PrivacyModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => PrivacyStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const PrivacyPage()),
  ];
}
