import 'package:flutter_modular/flutter_modular.dart';

import 'package:omni_mediktor/src/mediktor_diagnosis_details/mediktor_diagnosis_details_page.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis_details/mediktor_diagnosis_details_store.dart';

class MediktorDiagnosisDetailsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MediktorDiagnosisDetailsStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) =>  MediktorDiagnosisDetailsPage(sessionId: args.data),
    ),
  ];
}
