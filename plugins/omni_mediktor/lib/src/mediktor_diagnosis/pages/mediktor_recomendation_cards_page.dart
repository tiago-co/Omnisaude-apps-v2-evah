import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_mediktor/src/core/models/recomendation_modules_model.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/stores/recomendation_store.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/widgets/recomendation_card_widget.dart';
import 'package:omni_mediktor_labels/labels.dart';
import 'package:omni_scheduling/omni_scheduling.dart';

class MediktorRecomendationCardsPage extends StatefulWidget {
  final String specialtyId;
  const MediktorRecomendationCardsPage({Key? key, required this.specialtyId}) : super(key: key);

  @override
  _MediktorRecomendationCardsPageState createState() => _MediktorRecomendationCardsPageState();
}

class _MediktorRecomendationCardsPageState extends State<MediktorRecomendationCardsPage> {
  final RecomendationStore store = Modular.get<RecomendationStore>();
  final UserStore userStore = Modular.get<UserStore>();

  @override
  void initState() {
    store.getModules(widget.specialtyId);

    super.initState();
  }

  bool moduleIsActive(ModuleType moduleType) {
    bool moduleIsActive = false;

    userStore.programSelected.currentPhase!.modules!.forEach((module) {
      if (module.type == moduleType) {
        moduleIsActive = true;
        return;
      }
    });

    return moduleIsActive;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: MediktorLabels.mediktorRecomendationCardsTitle,
      ).build(context) as AppBar,
      body: TripleBuilder<RecomendationStore, Exception, RecomendationModulesModel>(
        store: store,
        builder: (_, triple) {
          if (triple.isLoading) {
            return const LoadingWidget();
          }

          if (triple.event == TripleEvent.error) {
            final DioError error = triple.error as DioError;
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      physics: const BouncingScrollPhysics(),
                      child: error.response!.statusCode == 404
                          ? RequestErrorWidget(
                              buttonText: MediktorLabels.mediktorRecomendationCardsErrorButton,
                              message: MediktorLabels.mediktorRecomendationCardsError,
                              onPressed: () async {
                                Modular.to.pop();
                              },
                            )
                          : RequestErrorWidget(
                              error: store.error,
                              onPressed: () async {
                                await store.getModules(widget.specialtyId);
                              },
                            ),
                    ),
                  ),
                ),
              ],
            );
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    if (store.state.bot)
                      RecomendationCardWidget(
                        asset: Assets.bot,
                        baseAsset: Assets.botBase,
                        package: AssetsPackage.omniGeneral,
                        title: MediktorLabels.mediktorRecomendationCardsBotTitle,
                        description: MediktorLabels.mediktorRecomendationCardsBotDescription,
                        onTap: () => Modular.to.pushNamed(
                          'bot_recommendations',
                          arguments: widget.specialtyId,
                        ),
                      ),
                    if (store.state.schedule && moduleIsActive(ModuleType.teleAttendance))
                      RecomendationCardWidget(
                        asset: Assets.scheduling,
                        baseAsset: Assets.schedulingBase,
                        package: AssetsPackage.omniGeneral,
                        title: MediktorLabels.mediktorRecomendationCardsTeleAttendanceTitle,
                        description: MediktorLabels.mediktorRecomendationCardsTeleAttendanceDescription,
                        onTap: () => Modular.to.pushNamed(
                          '../../schedulings/newScheduling/',
                          arguments: {
                            'moduleName': MediktorLabels.mediktorRecomendationCardsTeleAttendanceTitle,
                            'beneficiaryId': userStore.state.jwt!.id,
                            'schedulingType': SchedulingType.teleAttendance,
                            'schedulingMode': SchedulingModeModel(
                              schedulingModeType: SchedulingModeType.mediktor,
                              mediktorId: widget.specialtyId,
                            ),
                          },
                        ),
                      ),
                    if (store.state.schedule && moduleIsActive(ModuleType.presential))
                      RecomendationCardWidget(
                        asset: Assets.scheduling,
                        baseAsset: Assets.schedulingBase,
                        package: AssetsPackage.omniGeneral,
                        title: MediktorLabels.mediktorRecomendationCardsPresentaionTitle,
                        description: MediktorLabels.mediktorRecomendationCardsPresentaionDescription,
                        onTap: () => Modular.to.pushNamed(
                          '../../schedulings/newScheduling/newConsultation',
                          arguments: {
                            'moduleName': MediktorLabels.mediktorRecomendationCardsPresentaionTitle,
                            'beneficiaryId': userStore.state.jwt!.id,
                            'schedulingType': SchedulingType.presential,
                            'schedulingMode': SchedulingModeModel(
                              schedulingModeType: SchedulingModeType.mediktor,
                              mediktorId: widget.specialtyId,
                            ),
                          },
                        ),
                      ),
                    if (store.state.informative)
                      RecomendationCardWidget(
                        asset: Assets.informative,
                        baseAsset: Assets.informativeBase,
                        package: AssetsPackage.omniGeneral,
                        title: MediktorLabels.mediktorRecomendationCardsInformativeTitle,
                        description: MediktorLabels.mediktorRecomendationCardsInformativeDescription,
                        onTap: () => Modular.to.pushNamed(
                          '/home/informativesCategory/informatives_mediktor',
                          arguments: widget.specialtyId,
                        ),
                      ),
                    if (store.state.measurement)
                      RecomendationCardWidget(
                        asset: Assets.measurement,
                        baseAsset: Assets.informativeBase,
                        package: AssetsPackage.omniGeneral,
                        title: MediktorLabels.mediktorRecomendationCardsMeasurementTitle,
                        description: MediktorLabels.mediktorRecomendationCardsmeaturementDescription,
                        onTap: () => Modular.to.pushNamed(
                          '/home/measurements/newMeasurement',
                          arguments: {
                            'moduleName': 'Nova Medição',
                            'specialtyId': widget.specialtyId,
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
