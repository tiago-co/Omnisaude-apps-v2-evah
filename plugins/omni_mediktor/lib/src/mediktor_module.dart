import 'package:flutter_modular/flutter_modular.dart';

import 'package:omni_mediktor/src/mediktor_diagnosis/mediktor_diagnosis_module.dart';
import 'package:omni_mediktor/src/mediktor_historic/mediktor_historic_module.dart';

class MediktorModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/historic', module: MediktorHistoricModule()),
    ModuleRoute('/diagnosis', module: MediktorDiagnosisModule()),
  ];
}
