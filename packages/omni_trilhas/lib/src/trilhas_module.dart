import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_trilhas/src/modules/evolution_form/pages/evolution_form_details_page/evolution_form_details_page.dart';
import 'package:omni_trilhas/src/modules/evolution_form/pages/evolution_form_page.dart';
import 'package:omni_trilhas/src/modules/evolution_form/evolution_form_repository.dart';
import 'package:omni_trilhas/src/modules/evolution_form/stores/generic_evolution_form_store.dart';
import 'package:omni_trilhas/src/modules/evolution_form/stores/medical_evolution_form_store.dart';
import 'package:omni_trilhas/src/modules/evolution_form/stores/nurse_evolution_form_store.dart';

class TrilhasModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MedicalEvolutionFormStore()),
    Bind.lazySingleton((i) => NurseEvolutionFormStore()),
    Bind.factory((i) => GenericEvolutionFormStore()),
    Bind.lazySingleton(
        (i) => EvolutionFormRepository(i.get<DioHttpClientImpl>()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const EvolutionFormPage(),
    ),
    ChildRoute(
      '/evolution_details',
      child: (context, args) => EvolutionFormDetailsPage(
        evolutionForm: args.data,
      ),
    ),
  ];
}
