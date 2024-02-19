import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/presential_consultation/presential_consultation_page.dart';

class PresentialConsultationModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => PresentialConsultationPage(),
    ),
  ];
}
