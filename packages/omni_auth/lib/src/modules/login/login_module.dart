import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/login/login_page.dart';
import 'package:omni_auth/src/modules/login/stores/login_store.dart';
import 'package:omni_auth/src/modules/login/stores/obscure_text_store.dart';
import 'package:omni_auth/src/modules/register/register_repository.dart';
import 'package:omni_general/src/stores/use_biometrics_store.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore()),
    Bind.lazySingleton((i) => ObscureTextStore()),
    Bind.lazySingleton((i) => RegisterRepository()),
    Bind.lazySingleton((i) => UseBiometricsStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const LoginPage()),
  ];
}
