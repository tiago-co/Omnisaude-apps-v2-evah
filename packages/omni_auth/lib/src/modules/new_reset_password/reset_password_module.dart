import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/new_reset_password/new_password_reset_page.dart';
import 'package:omni_auth/src/modules/new_reset_password/request_reset_password_page.dart';

import 'package:omni_auth/src/modules/reset_password/reset_password_repository.dart';
import 'package:omni_auth/src/modules/reset_password/reset_password_store.dart';

class NewResetPasswordModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ResetPasswordStore()),
    Bind.lazySingleton((i) => ResetPasswordRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => RequestResetPasswordPage(),
    ),
    ChildRoute(
      '/resetPassword',
      child: (_, args) => NewPasswordResetPage(),
    ),
  ];
}
