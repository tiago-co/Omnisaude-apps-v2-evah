import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/sign_up/email_confirmation/email_confirmation.dart';
import 'package:omni_auth/src/modules/sign_up/password/password_page.dart';
import 'package:omni_auth/src/modules/sign_up/sign_up/sign_up_page.dart';
import 'package:omni_auth/src/modules/sign_up/welcome.dart';

class SignUpModule extends Module {
  @override
  // TODO: implement binds
  List<Bind<Object>> get binds => super.binds;
  @override
  // TODO: implement routes
  List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => Welcome(),
    ),
    ChildRoute(
      '/emailConfirmation',
      child: (_, args) => const EmailConfirmation(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      '/password',
      child: (_, args) => const PasswordPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      '/signUpPage',
      child: (_, args) => const SignUpPage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
