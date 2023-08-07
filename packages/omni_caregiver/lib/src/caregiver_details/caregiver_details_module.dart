import 'package:flutter_modular/flutter_modular.dart';

import 'package:omni_caregiver/src/caregiver_details/caregiver_details_page.dart';
import 'package:omni_caregiver/src/caregiver_details/stores/caregiver_details_store.dart';

class CaregiverDetailsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CaregiverDetailsStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => CaregiverDetailsPage(caregiver: args.data),
    ),
  ];
}
