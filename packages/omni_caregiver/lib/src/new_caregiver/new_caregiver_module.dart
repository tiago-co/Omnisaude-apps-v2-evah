import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_caregiver/src/caregivers_repository.dart';
import 'package:omni_caregiver/src/new_caregiver/new_caregiver_store.dart';
import 'package:omni_caregiver/src/new_caregiver/pages/new_caregiver_page.dart';
import 'package:omni_general/omni_general.dart';

class NewCaregiverModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => NewCaregiverStore()),
    Bind.lazySingleton((i) => CaregiversRepository(i.get<DioHttpClientImpl>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => NewCaregiverPage(moduleName: args.data),
    ),
  ];
}
