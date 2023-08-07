import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_assistance/src/assistance/pages/assistance_details_page.dart';
import 'package:omni_assistance/src/assistance/pages/assistance_page.dart';
import 'package:omni_assistance/src/assistance/assistance_repository.dart';
import 'package:omni_assistance/src/assistance/stores/assistance_status_filter_store.dart';
import 'package:omni_assistance/src/assistance/stores/assistance_store.dart';
import 'package:omni_assistance/src/assistance/stores/assistances_store.dart';
import 'package:omni_assistance/src/assistance/pages/create_assistance_page.dart';
import 'package:omni_general/omni_general.dart';

class AssistanceModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AssistanceStore()),
    Bind.lazySingleton((i) => AssistancesStore()),
    Bind.lazySingleton((i) => AssistanceStatusFilterStore()),
    Bind.lazySingleton((i) => AssistanceRepository(i.get<DioHttpClientImpl>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const AssistancePage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      '/create_assistance',
      child: (_, args) => const CreateAssistancePage(),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      '/assistance_details',
      child: (_, args) => AssistanceDetailsPage(
        assistance: args.data,
      ),
      transition: TransitionType.fadeIn,
    ),
  ];
}
