import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';

class PlanModulesStore extends NotifierStore<DioError, List<ModuleModel>> {
  PlanModulesStore() : super([]);

  final ModulesStore modulesStore = Modular.get();
  final ModuleRepository _repository = Modular.get();
  List<ModuleModel> modulesList = [];

  Future<void> getPlanModules() async {
    update([]);
    modulesList = [];
    setLoading(true);
    await _repository.getActiveModules().then(
      (modules) {
        modules!.forEach(
          (module) {
            if (module.category == ModuleCategoryType.home) {
              modulesList.add(module);
            }
          },
        );
        update(modulesList);
        setLoading(false);
      },
    ).catchError(
      (onError) {
        setLoading(false);
        throw onError;
      },
    );
  }
}
