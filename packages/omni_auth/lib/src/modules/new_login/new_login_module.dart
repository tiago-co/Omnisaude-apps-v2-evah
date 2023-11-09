import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/login/stores/obscure_text_store.dart';
import 'package:omni_auth/src/modules/new_login/sign_in/new_reset_password_page.dart';
import 'package:omni_auth/src/modules/new_login/sign_in/sign_in_page.dart';
import 'package:omni_auth/src/modules/new_login/store/new_login_store.dart';
import 'package:omni_auth/src/modules/register/register_repository.dart';
import 'package:omni_general/omni_general.dart';

class NewLoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => NewLoginStore()),
    Bind.lazySingleton((i) => ObscureTextStore()),
    Bind.lazySingleton((i) => RegisterRepository()),
    Bind.lazySingleton((i) => UseBiometricsStore()),
  ];
  @override
  // TODO: implement routes
  List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => SignInPage(),
    ),
    ChildRoute(
      '/resetPassword',
      child: (_, args) => const NewResetPasswordPage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
