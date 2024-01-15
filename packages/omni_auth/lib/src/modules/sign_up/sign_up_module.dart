import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/register/register_repository.dart';
import 'package:omni_auth/src/modules/register/stores/register_store.dart';
import 'package:omni_auth/src/modules/register/stores/register_terms_store.dart';
import 'package:omni_auth/src/modules/sign_up/email_confirmation/email_confirmation.dart';
import 'package:omni_auth/src/modules/sign_up/password/password_page.dart';
import 'package:omni_auth/src/modules/sign_up/sign_up/sign_up_page.dart';
import 'package:omni_auth/src/modules/sign_up/welcome.dart';
import 'package:omni_general/omni_general.dart';

class SignUpModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => RegisterStore()),
    Bind.lazySingleton((i) => ZipCodeStore()),
    Bind.lazySingleton((i) => RegisterTermsStore()),
    Bind.lazySingleton((i) => RegisterRepository()),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => Welcome(),
    ),
    ChildRoute(
      '/emailConfirmation',
      child: (_, args) => PasswordPage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      '/emailConfirmationSent',
      child: (_, args) => EmailConfirmation(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      '/signUpPage',
      child: (_, args) => SignUpPage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
