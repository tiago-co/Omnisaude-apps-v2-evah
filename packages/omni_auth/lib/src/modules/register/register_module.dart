import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/register/pages/register_page.dart';
import 'package:omni_auth/src/modules/register/register_repository.dart';
import 'package:omni_auth/src/modules/register/stores/register_store.dart';
import 'package:omni_auth/src/modules/register/stores/register_terms_store.dart';

class RegisterModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => RegisterStore()),
    Bind.lazySingleton((i) => RegisterTermsStore()),
    Bind.lazySingleton((i) => RegisterRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const RegisterPage()),
  ];
}
