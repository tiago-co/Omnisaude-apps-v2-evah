import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_drug_control/src/drug_control_details/drug_control_details_page.dart';
import 'package:omni_drug_control/src/drug_control_details/drug_control_details_repository.dart';
import 'package:omni_drug_control/src/drug_control_details/drug_control_details_store.dart';
import 'package:omni_general/omni_general.dart';

class DrugControlDetailsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DrugControlDetailsStore()),
    Bind.lazySingleton(
      (i) => DrugControlDetailsRepository(i.get<DioHttpClientImpl>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => DrugControlDetailsPage(
        drugControl: args.data,
      ),
      transition: TransitionType.fadeIn,
    ),
  ];
}
