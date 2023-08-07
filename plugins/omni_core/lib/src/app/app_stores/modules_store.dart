import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/omni_scheduling.dart';

class ModulesStore extends NotifierStore<DioError, List<ModuleModel>>
    with Disposable {
  final ModuleRepository _repository = Modular.get();
  final UserStore userStore = Modular.get();

  ModulesStore() : super([]);

  Future<void> getActiveModules() async {
    setLoading(true);
    await _repository.getActiveModules().then((modules) {
      modules!.sort((a, b) => a.name!.compareTo(b.name!));
      update(modules);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
      throw onError;
    });
  }

  Function? navigate(ModuleModel module) {
    switch (module.type) {
      case ModuleType.scheduling:
        Modular.to.pushNamed(
          '/home/schedulings/historic',
          arguments: {
            'moduleName': module.name ?? module.type,
            'beneficiaryId': userStore.state.jwt!.id,
          },
        );
        break;
      case ModuleType.presential:
        Modular.to.pushNamed(
          '/home/schedulings/historic',
          arguments: {
            'moduleName': module.name ?? module.type,
            'beneficiaryId': userStore.state.jwt!.id,
            'schedulingType': SchedulingType.presential,
            'schedulingModeModel': SchedulingModeModel(
              schedulingModeType: SchedulingModeType.simple,
            ),
          },
        );
        break;
      case ModuleType.teleAttendance:
        Modular.to.pushNamed(
          '/home/schedulings/historic',
          arguments: {
            'moduleName': module.name ?? module.type,
            'schedulingType': SchedulingType.teleAttendance,
            'beneficiaryId': userStore.state.jwt!.id,
            'schedulingModeModel': SchedulingModeModel(
              schedulingModeType: SchedulingModeType.simple,
            ),
          },
        );
        break;
      case ModuleType.mediktor:
        Modular.to.pushNamed(
          '/home/mediktor/historic',
          arguments: module.name,
        );
        break;
      case ModuleType.drugControl:
        Modular.to.pushNamed(
          '/home/drugControl/drugControlHistoric',
          arguments: {
            'moduleName': module.name,
            'program': userStore.programSelected,
          },
        );
        break;
      case ModuleType.bot:
        Modular.to.pushNamed(
          '/home/bots',
          arguments: {
            'title': module.name,
            'botId': module.botId ?? '',
            'jwt': userStore.state.jwt,
            'beneficiary': userStore.state.beneficiary,
          },
        );
        break;
      case ModuleType.exams:
        Modular.to.pushNamed(
          '/home/exams',
          arguments: module.name,
        );
        break;
      case ModuleType.diseases:
        Modular.to.pushNamed(
          '/home/diseases',
          arguments: {
            'moduleName': module.name ?? module.type,
          },
        );
        break;

      case ModuleType.informative:
        Modular.to.pushNamed(
          '/home/informativesCategory',
          arguments: module.name,
        );
        break;
      case ModuleType.vaccines:
        Modular.to.pushNamed(
          '/home/vaccines',
          arguments: module.name,
        );
        break;
      case ModuleType.caregiver:
        Modular.to.pushNamed(
          '/home/caregivers',
          arguments: module.name,
        );
        break;
      case ModuleType.measurement:
        Modular.to.pushNamed(
          '/home/measurements/historic',
          arguments: module.name,
        );
        break;
      case ModuleType.procedure:
        Modular.to.pushNamed(
          '/home/procedures',
          arguments: module.name,
        );
        break;
      case ModuleType.extraData:
        Modular.to.pushNamed(
          '/home/extraData',
          arguments: module.name,
        );
        break;
      case ModuleType.pharmacyDiscount:
        Modular.to.pushNamed(
          '/home/discounts',
          arguments: {
            'moduleName': module.name,
            'categoryParam': '19',
          },
        );
        break;
      case ModuleType.examsDiscount:
        Modular.to.pushNamed(
          '/home/discounts',
          arguments: {
            'moduleName': module.name,
            'categoryParam': '189',
          },
        );
        break;
      case ModuleType.otherAdvantages:
        Modular.to.pushNamed(
          '/home/discounts',
          arguments: {
            'moduleName': module.name,
            'categoryParam': '',
          },
        );
        break;
      case ModuleType.urgencyAttendance:
        Modular.to.pushNamed(
          '/home/teleattendanceUrgency',
          arguments: module.name,
        );
        break;

      default:
        _unknownModuleWarning();
        return null;
    }
    return null;
  }

  void _unknownModuleWarning() {
    Modular.to.push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (context, animation, secondaryAnimation) {
          animation = Tween(begin: 0.0, end: 1.0).animate(
            animation,
          );
          return FadeTransition(
            opacity: animation,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.1,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Theme.of(context).cardColor,
                          width: 0.05,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: -5,
                            color: Theme.of(context).cardColor.withOpacity(0.5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Material(
                          color: Colors.transparent,
                          child: RequestErrorWidget(
                            buttonText: 'Fechar',
                            message: 'Módulo em manutenção!\n\n'
                                'Estamos trabalhando para disponibilizar '
                                'novas funcionalidades.',
                            onPressed: () => Modular.to.pop(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
