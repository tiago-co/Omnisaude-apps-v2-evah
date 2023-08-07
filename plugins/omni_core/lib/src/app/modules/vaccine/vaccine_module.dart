import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/vaccine/pages/vaccine_details_page.dart';
import 'package:omni_core/src/app/modules/vaccine/pages/vaccine_page.dart';
import 'package:omni_core/src/app/modules/vaccine/vaccine_repository.dart';

import 'package:omni_core/src/app/modules/vaccine/vaccine_store.dart';

class VaccineModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => VaccineStore()),
    Bind.lazySingleton((i) => VaccineRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => VaccinePage(moduleName: args.data),
    ),
    ChildRoute(
      '/vaccine_details',
      child: (_, args) => VaccineDetailsPage(
        vaccineModel: args.data,
      ),
    ),
  ];
}
