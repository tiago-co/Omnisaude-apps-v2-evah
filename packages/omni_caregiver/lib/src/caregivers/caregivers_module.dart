import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_caregiver/src/caregiver_details/caregiver_details_module.dart';
import 'package:omni_caregiver/src/caregivers/caregivers_page.dart';
import 'package:omni_caregiver/src/caregivers/caregivers_store.dart';
import 'package:omni_caregiver/src/caregivers_repository.dart';
import 'package:omni_caregiver/src/new_caregiver/new_caregiver_module.dart';
import 'package:omni_general/omni_general.dart';

class CaregiversModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CaregiversStore()),
    Bind.lazySingleton((i) => CaregiversRepository(i.get<DioHttpClientImpl>()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => CaregiversPage(moduleName: args.data),
    ),
    ModuleRoute('/newCaregiver', module: NewCaregiverModule()),
    ModuleRoute('/caregiverDetails', module: CaregiverDetailsModule()),
  ];
}
