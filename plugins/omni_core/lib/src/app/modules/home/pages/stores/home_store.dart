import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/app_stores/modules_store.dart';
import 'package:omni_core/src/app/app_stores/program_store.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/module_category_store.dart';
import 'package:omni_general/omni_general.dart';

class HomeStore extends NotifierStore<Exception, ModuleCategoryType> {
  final UserStore userStore = Modular.get();
  final ModulesStore modulesStore = Modular.get();
  final ProgramStore programStore = Modular.get();
  final ModuleCategoryStore categoryStore = Modular.get();

  HomeStore() : super(ModuleCategoryType.diagnosis);
}
