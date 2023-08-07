import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/reset_password/pages/reset_password_page.dart';
import 'package:omni_auth/src/modules/reset_password/reset_password_repository.dart';
import 'package:omni_auth/src/modules/reset_password/reset_password_store.dart';

class ResetPasswordModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ResetPasswordStore()),
    Bind.lazySingleton((i) => ResetPasswordRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ResetPasswordPage(),
    ),
  ];
}
