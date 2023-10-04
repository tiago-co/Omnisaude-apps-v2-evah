import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/new_login/sign_in/new_reset_password_page.dart';
import 'package:omni_auth/src/modules/new_login/sign_in/sign_in_page.dart';

class NewLoginModule extends Module {
  @override
  // TODO: implement binds
  List<Bind<Object>> get binds => super.binds;
  @override
  // TODO: implement routes
  List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const SignInPage(),
    ),
    ChildRoute(
      '/resetPassword',
      child: (_, args) => const NewResetPasswordPage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
