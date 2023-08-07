import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/extra_data/extra_data_repository.dart';
import 'package:omni_core/src/app/modules/extra_data/pages/extra_data_page.dart';
import 'package:omni_core/src/app/modules/extra_data/pages/stores/extra_data_historic_store.dart';
import 'package:omni_core/src/app/modules/extra_data/pages/stores/extra_data_store.dart';
import 'package:omni_core/src/app/modules/extra_data/pages/stores/extra_data_type_store.dart';
import 'package:omni_general/omni_general.dart';

class ExtraDataModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ExtraDataStore()),
    Bind.lazySingleton((i) => ExtraDataTypeStore()),
    Bind.lazySingleton((i) => ExtraDataHistoricStore()),
    Bind.lazySingleton((i) => ExtraDataRepository(i.get<DioHttpClientImpl>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => ExtraDataPage(moduleName: args.data),
    ),
  ];
}
