import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';

import 'package:omni_plan/src/modules/features_contacts/features_contacts_page.dart';
import 'package:omni_plan/src/modules/features_contacts/features_contacts_repository.dart';
import 'package:omni_plan/src/modules/features_contacts/features_contacts_store.dart';

class FeaturesContactsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => FeaturesContactsStore()),
    Bind.lazySingleton(
      (i) => FeaturesContactsRepository(i.get<DioHttpClientImpl>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => FeaturesContactsPage(
        moduleName: args.data['moduleName'],
      ),
    ),
  ];
}
