import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_caregiver/omni_caregiver.dart' show NewCaregiverModule;
import 'package:omni_drug_control/src/new_drug_control/new_drug_control_repository.dart';
import 'package:omni_drug_control/src/new_drug_control/pages/new_drug_control_page.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_administration_store.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_dosage_store.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_medicine_store.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_observation_store.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_store.dart';
import 'package:omni_drug_control/src/new_drug_control/stores/new_drug_control_unity_store.dart';
import 'package:omni_general/omni_general.dart';

class NewDrugControlModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => NewDrugControlStore()),
    Bind.lazySingleton((i) => NewDrugControlUnityStore()),
    Bind.lazySingleton((i) => NewDrugControlDosageStore()),
    Bind.lazySingleton((i) => NewDrugControlMedicineStore()),
    Bind.lazySingleton((i) => NewDrugControlObservationStore()),
    Bind.lazySingleton((i) => NewDrugControlAdministrationStore()),
    Bind.lazySingleton(
      (i) => NewDrugControlRepository(i.get<DioHttpClientImpl>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => NewDrugControlPage(
        useCustomMedication: args.data['useCustomMedication'],
        useCaregiver: args.data['useCaregiver'],
        moduleName: args.data['moduleName'],
        program: args.data['program'],
      ),
    ),
    ModuleRoute('/newCaregiver', module: NewCaregiverModule()),
  ];
}
