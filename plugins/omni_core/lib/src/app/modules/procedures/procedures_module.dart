import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/procedures/crisis_diary_repository.dart';
import 'package:omni_core/src/app/modules/procedures/pages/crisis_diary_page.dart';
import 'package:omni_core/src/app/modules/procedures/pages/procedures_page.dart';
import 'package:omni_core/src/app/modules/procedures/procedures_repository.dart';
import 'package:omni_core/src/app/modules/procedures/stores/crisis_diary_historic_store.dart';
import 'package:omni_core/src/app/modules/procedures/stores/crisis_diary_store.dart';
import 'package:omni_core/src/app/modules/procedures/stores/crisis_diary_type_filter_store.dart';
import 'package:omni_core/src/app/modules/procedures/stores/procedure_details_store.dart';
import 'package:omni_core/src/app/modules/procedures/stores/procedures_date_filter_store.dart';
import 'package:omni_core/src/app/modules/procedures/stores/procedures_store.dart';
import 'package:omni_general/omni_general.dart';

class ProceduresModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProceduresStore()),
    Bind.lazySingleton((i) => CrisisDiaryStore()),
    Bind.lazySingleton((i) => ProcedureDetailsStore()),
    Bind.lazySingleton((i) => CrisisDiaryHistoricStore()),
    Bind.lazySingleton((i) => ProceduresDateFilterStore()),
    Bind.lazySingleton((i) => CrisisDiaryTypeFilterStore()),
    Bind.lazySingleton((i) => ProceduresRepository(i.get<DioHttpClientImpl>())),
    Bind.lazySingleton(
      (i) => CrisisDiaryRepository(i.get<DioHttpClientImpl>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => ProceduresPage(moduleName: args.data),
    ),
    ChildRoute(
      '/crisisDiary',
      child: (_, args) => CrisisDiaryPage(moduleName: args.data),
    ),
  ];
}
