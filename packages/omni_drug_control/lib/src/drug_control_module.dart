import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_drug_control/src/drug_control_details/drug_control_details_module.dart';
import 'package:omni_drug_control/src/drug_control_historic/drug_control_historic_repository.dart';
import 'package:omni_drug_control/src/drug_control_historic/pages/drug_control_historic_page.dart';
import 'package:omni_drug_control/src/drug_control_historic/stores/consuption_store.dart';
import 'package:omni_drug_control/src/drug_control_historic/stores/drug_control_date_filter_store.dart';
import 'package:omni_drug_control/src/drug_control_historic/stores/drug_control_historic_store.dart';
import 'package:omni_drug_control/src/drug_control_historic/stores/drug_control_type_filter_store.dart';
import 'package:omni_drug_control/src/drug_control_historic/stores/medicine_historic_store.dart';
import 'package:omni_drug_control/src/new_drug_control/new_drug_control_module.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_caregiver_notifications_store.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_caregiver_store.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_list_caregiver_store.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_program_disease_store.dart';
import 'package:omni_general/omni_general.dart';

class DrugControlModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MedicineHistoricStore()),
    Bind.lazySingleton((i) => DrugControlHistoricStore()),
    Bind.lazySingleton((i) => DrugControlTypeFilterStore()),
    Bind.lazySingleton((i) => NewDrugControlCaregiverStore()),
    Bind.lazySingleton((i) => MedicineHistoricDateFilterStore()),
    Bind.lazySingleton((i) => NewDrugControlProgramDiseaseStore()),
    Bind.lazySingleton((i) => NewDrugControlListCaregiverStore()),
    Bind.lazySingleton((i) => ConsuptionStore()),
    Bind.factory((i) => NewDrugControlCaregiverNotificationsStore()),
    Bind.lazySingleton(
      (i) => DrugControlHistoricRepository(i.get<DioHttpClientImpl>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/drugControlHistoric',
      child: (_, args) => DrugControlHistoricPage(
        moduleName: args.data['moduleName'],
        program: args.data['program'],
      ),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/newDrugControl',
      module: NewDrugControlModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/drugControlDetails',
      module: DrugControlDetailsModule(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
