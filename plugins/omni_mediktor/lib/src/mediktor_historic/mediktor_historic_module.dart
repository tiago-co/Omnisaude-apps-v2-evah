import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/mediktor_diagnosis_module.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/pages/mediktor_bot_recomendations_page.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/pages/mediktor_recomendation_cards_page.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/pages/mediktor_recomendation_diagnosis_page.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/stores/bot_recommendation_store.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/stores/mediktor_recomendation_store.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/stores/recomendation_store.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis_details/mediktor_diagnosis_details_module.dart';

import 'package:omni_mediktor/src/mediktor_historic/mediktor_historic_page.dart';
import 'package:omni_mediktor/src/mediktor_historic/stores/mediktor_historic_date_filter_store.dart';
import 'package:omni_mediktor/src/mediktor_historic/stores/mediktor_historic_store.dart';

class MediktorHistoricModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MediktorHistoricStore()),
    Bind.lazySingleton((i) => MediktorHistoricDateFilterStore()),
    Bind.lazySingleton((i) => MediktorRecomendationStore()),
    Bind.lazySingleton((i) => RecomendationStore()),
    Bind.lazySingleton((i) => BotRecommendationStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => MediktorHistoricPage(moduleName: args.data),
    ),
    ModuleRoute('/diagnosisDetails', module: MediktorDiagnosisDetailsModule()),
    ModuleRoute('/diagnosis', module: MediktorDiagnosisModule()),
    ChildRoute(
      '/mediktorRecomendationDiagnosisPage',
      child: (_, args) => MediktorRecomendationDiagnosisPage(
        recomendationModel: args.data,
      ),
    ),
    ChildRoute(
      '/mediktorRecomendationCardsPage',
      child: (_, args) => MediktorRecomendationCardsPage(
        specialtyId: args.data,
      ),
    ),
    ChildRoute(
      '/bot_recommendations',
      child: (_, args) => MediktorBotRecomendationsPage(
        specialtyId: args.data,
      ),
    ),
  ];
}
