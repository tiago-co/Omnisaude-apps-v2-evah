import 'package:diseases/src/modules/diseases/diseases_repository.dart';
import 'package:diseases/src/modules/diseases/pages/create_new_disease_page.dart';
import 'package:diseases/src/modules/diseases/stores/disease_category_type_store.dart';
import 'package:diseases/src/modules/diseases/stores/disease_store.dart';
import 'package:diseases/src/modules/diseases/stores/disease_type_filter_store.dart';
import 'package:diseases/src/modules/diseases/stores/diseases_list_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';

import 'modules/diseases/pages/diseases_page.dart';
import 'modules/diseases/stores/alergies_list_store.dart';
import 'modules/diseases/stores/allergy_store.dart';
import 'modules/diseases/stores/new_diseases_store.dart';

class DiseasesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DiseaseTypeFilterStore(0)),
    Bind.lazySingleton((i) => DiseaseCategoryTypeStore()),
    Bind.lazySingleton((i) => DiseaseStore()),
    Bind.lazySingleton((i) => AllergyStore()),
    Bind.lazySingleton((i) => NewDiseasesStore()),
    Bind.lazySingleton((i) => DiseasesListStore()),
    Bind.lazySingleton((i) => AllergiesListStore()),
    Bind.lazySingleton((i) => DiseasesRepository(i.get<DioHttpClientImpl>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => DiseasesPage(moduleName: args.data['moduleName']),
    ),
    ChildRoute(
      '/createDisease',
      child: (_, args) => const CreateNewDiseasePage(),
    ),
  ];
}
