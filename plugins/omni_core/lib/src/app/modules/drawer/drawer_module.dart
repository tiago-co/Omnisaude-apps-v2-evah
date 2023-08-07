import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_assistance/omni_assistance.dart';
import 'package:omni_core/src/app/modules/drawer/drawer_page.dart';
import 'package:omni_core/src/app/modules/drawer/stores/about_store.dart';
import 'package:omni_core/src/app/modules/drawer/stores/add_program_store.dart';
import 'package:omni_core/src/app/modules/drawer/stores/drawer_store.dart';
import 'package:omni_core/src/app/modules/drawer/stores/inactivate_program_store.dart';
import 'package:omni_core/src/app/modules/help/help_module.dart';
import 'package:omni_core/src/app/modules/my_devices/my_devices_module.dart';
import 'package:omni_core/src/app/modules/my_devices/stores/my_devices_store.dart';
import 'package:omni_core/src/app/modules/privacy/privacy_module.dart';
import 'package:omni_trilhas/omni_trilhas.dart';

class DrawerModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DrawerStore()),
    Bind.lazySingleton((i) => AddProgramStore()),
    Bind.lazySingleton((i) => MyDevicesStore()),
    Bind.lazySingleton((i) => InactivateProgramStore()),
    Bind.lazySingleton((i) => AboutStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const DrawerPage()),
    ModuleRoute('/privacy', module: PrivacyModule()),
    ModuleRoute('/help', module: HelpModule()),
    ModuleRoute('/my_devices', module: MyDevicesModule()),
    ModuleRoute('/assistance', module: AssistanceModule()),
    ModuleRoute('/evolution_form', module: TrilhasModule()),
  ];
}
