import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/auth_repository.dart';

import 'package:omni_auth/src/auth_store.dart';
import 'package:omni_auth/src/modules/login/login_module.dart';
import 'package:omni_auth/src/modules/register/register_module.dart';
import 'package:omni_auth/src/modules/reset_password/reset_password_module.dart';
import 'package:omni_general/omni_general.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AuthRepository()),
    Bind.lazySingleton((i) => AuthStore()),
    Bind.lazySingleton((i) => LecuponRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/register', module: RegisterModule()),
    ModuleRoute('/resetPassword', module: ResetPasswordModule()),
  ];
}
