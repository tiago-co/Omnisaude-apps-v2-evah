import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/omni_measurement.dart';
import 'package:omni_mediktor/omni_mediktor.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/mediktor_diagnosis_store.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/pages/mediktor_bot_recomendations_page.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/pages/mediktor_diagnosis_page.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/pages/mediktor_recomendation_cards_page.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/pages/mediktor_recomendation_diagnosis_page.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/stores/bot_recommendation_store.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/stores/mediktor_recomendation_store.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/stores/recomendation_store.dart';

class MediktorDiagnosisModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MediktorDiagnosisStore()),
    Bind.lazySingleton((i) => MediktorRecomendationStore()),
    Bind.lazySingleton((i) => RecomendationStore()),
    Bind.lazySingleton((i) => BotRecommendationStore()),
    Bind.lazySingleton((i) => MeasurementHistoricStore()),
    Bind.lazySingleton((i) => NewMeasurementStore()),
    Bind.lazySingleton((i) => MediktorMeasurementTypeStore()),
    Bind.lazySingleton(
      (i) => MeasumentHistoricRepository(i.get<DioHttpClientImpl>()),
    ),
    // Bind.lazySingleton((i) => MediktorRepository(i.get<Dio>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => MediktorDiagnosisPage(moduleName: args.data),
    ),
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
