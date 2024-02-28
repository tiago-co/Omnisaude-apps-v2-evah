import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/first_access/pages/first_acess_form.dart';
import 'package:omni_auth/src/modules/first_access/pages/first_acess_page.dart';
import 'package:omni_auth/src/modules/first_access/store/first_acess_store.dart';
import 'package:omni_general/omni_general.dart';

class FirstAcessModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => FirstAcessStore()),
    Bind.lazySingleton((i) => BeneficiaryRepository(DioHttpClientImpl(Dio()))),
  ];
  @override
  // TODO: implement routes
  List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => FirstAcessPage(),
    ),
    ChildRoute(
      '/firstAcessForm',
      child: (_, args) => FirstAcessForm(id: args.data['id']),
      transition: TransitionType.fadeIn,
    ),
  ];
}
