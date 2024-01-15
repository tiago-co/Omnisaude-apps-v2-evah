import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/new_settings/pages/settings_page.dart';
import 'package:omni_core/src/app/modules/new_settings/stores/settings_store.dart';
import 'package:omni_core/src/app/modules/settings/pages/notification_enabled_page.dart';
import 'package:omni_general/omni_general.dart';

class NewSettingsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SettingsStore()),
    Bind.lazySingleton((i) => UseBiometricsStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SettingsPage()),
    ChildRoute(
      '/notifications',
      child: (_, args) => const NotificationEnabledPage(),
    ),
  ];
}
