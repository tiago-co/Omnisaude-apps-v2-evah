import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';

import 'package:omni_plan/src/modules/guide_providers/guide_providers_page.dart';
import 'package:omni_plan/src/modules/guide_providers/guide_providers_repository.dart';
import 'package:omni_plan/src/modules/guide_providers/provider_details_page.dart';
import 'package:omni_plan/src/modules/guide_providers/stores/filters_store.dart';
import 'package:omni_plan/src/modules/guide_providers/stores/guide_providers_store.dart';
import 'package:omni_plan/src/modules/guide_providers/widgets/show_more/show_more_store.dart';

class GuideProvidersModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => GuideProvidersStore()),
    Bind.lazySingleton((i) => FiltersStore()),
    Bind.factory((i) => ShowMoreStore()),
    Bind.lazySingleton(
      (i) => GuideRepositoryRepository(i.get<DioHttpClientImpl>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => GuideProvidersPage(
        moduleName: args.data['moduleName'],
      ),
    ),
    ChildRoute(
      '/providerDetails',
      child: (_, args) => ProviderDetailsPage(
        provider: args.data['planProviderModel'],
      ),
    ),
  ];
}
