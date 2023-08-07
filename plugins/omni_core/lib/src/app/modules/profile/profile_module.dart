import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/profile/pages/profile_page.dart';
import 'package:omni_core/src/app/modules/profile/profile_store.dart';
import 'package:omni_general/omni_general.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProfileStore()),
    Bind.lazySingleton((i) => ZipCodeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const ProfilePage()),
  ];
}