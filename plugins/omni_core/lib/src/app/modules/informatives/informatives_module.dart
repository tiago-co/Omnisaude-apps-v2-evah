import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/informatives/informatives_repository.dart';
import 'package:omni_core/src/app/modules/informatives/pages/informative_details.dart';
import 'package:omni_core/src/app/modules/informatives/pages/informative_page.dart';
import 'package:omni_core/src/app/modules/informatives/pages/informatives_category_page.dart';
import 'package:omni_core/src/app/modules/informatives/pages/mediktor_informative_page.dart';
import 'package:omni_core/src/app/modules/informatives/stores/informative_details_store.dart';
import 'package:omni_core/src/app/modules/informatives/stores/informatives_category_store.dart';
import 'package:omni_core/src/app/modules/informatives/stores/informatives_store.dart';
import 'package:omni_core/src/app/modules/informatives/stores/mediktor_informative_store.dart';
import 'package:omni_general/omni_general.dart';

class InformativesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => InformativesStore()),
    Bind.lazySingleton((i) => InformativeDetailsStore()),
    Bind.lazySingleton((i) => InformativesCategoryStore()),
    Bind.lazySingleton((i) => MediktorInformativesStore()),
    Bind.lazySingleton(
      (i) => InformativesRepository(i.get<DioHttpClientImpl>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => InformativesCategoryPage(moduleName: args.data),
    ),
    ChildRoute(
      '/informatives',
      child: (_, args) => InformativesPage(pageName: args.data),
    ),
    ChildRoute(
      '/informatives_mediktor',
      child: (_, args) => MediktorInformativePage(specialtyId: args.data),
    ),
    ChildRoute(
      '/detailsInformative',
      child: (_, args) => InformativeDetails(
        informative: args.data,
      ),
    ),
  ];
}
