import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/auth_repository.dart';

import 'package:omni_auth/src/auth_store.dart';
import 'package:omni_auth/src/modules/first_access/first_acess_module.dart';
import 'package:omni_auth/src/modules/login/login_module.dart';
import 'package:omni_auth/src/modules/new_login/new_login_module.dart';
import 'package:omni_auth/src/modules/new_reset_password/reset_password_module.dart';
import 'package:omni_auth/src/modules/register/register_module.dart';
import 'package:omni_auth/src/modules/reset_password/reset_password_module.dart';
import 'package:omni_auth/src/modules/sign_up/sign_up_module.dart';
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
    // ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/newLogin', module: NewLoginModule()),
    // ModuleRoute('/register', module: RegisterModule()),
    ModuleRoute('/signUp', module: SignUpModule()),
    ModuleRoute('/resetPassword', module: ResetPasswordModule()),
    ModuleRoute('/password', module: NewResetPasswordModule()),
    ModuleRoute('/firstAcess', module: FirstAcessModule()),
  ];
}
