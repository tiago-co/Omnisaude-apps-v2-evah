import 'package:diseases/diseases.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_bot/omni_bot.dart' show OmniBotModule;
import 'package:omni_caregiver/omni_caregiver.dart' show CaregiversModule;
import 'package:omni_core/src/app/modules/benefits/discounts/discounts_module.dart';
import 'package:omni_core/src/app/modules/drawer/drawer_module.dart';
import 'package:omni_core/src/app/modules/exams/exams_module.dart';
import 'package:omni_core/src/app/modules/extra_data/extra_data_module.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/bottom_navigation_store.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/home_page.dart';
// import 'package:omni_core/src/app/modules/home/pages/home_page.dart';

import 'package:omni_core/src/app/modules/home/pages/home_presentation_page.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/home_store.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/module_category_store.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/omniplan_module_icon_store.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/unread_notifications_count_store.dart';
import 'package:omni_core/src/app/modules/informatives/informatives_module.dart';
import 'package:omni_core/src/app/modules/new_consultation/new_consultation_module.dart';
import 'package:omni_core/src/app/modules/new_consultation/new_consultation_page.dart';
import 'package:omni_core/src/app/modules/new_discounts/discounts_module.dart';
import 'package:omni_core/src/app/modules/new_profile/new_profile_module.dart';
import 'package:omni_core/src/app/modules/new_reminders/reminders_module.dart';
import 'package:omni_core/src/app/modules/new_reminders/repository/drug_control_historic_repository.dart';
import 'package:omni_core/src/app/modules/new_reminders/repository/new_drug_control_repository.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/drug_control_historic_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_store.dart';
import 'package:omni_core/src/app/modules/notifications/notifications_module.dart';
import 'package:omni_core/src/app/modules/procedures/procedures_module.dart';
import 'package:omni_core/src/app/modules/profile/profile_module.dart';
import 'package:omni_core/src/app/modules/profile/profile_store.dart';
import 'package:omni_core/src/app/modules/services/services_page.dart';
import 'package:omni_core/src/app/modules/settings/settings_module.dart';
import 'package:omni_core/src/app/modules/urgency_teleattendance/teleattendance_module.dart';
import 'package:omni_core/src/app/modules/vaccine/vaccine_module.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_administration_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_dosage_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_medicine_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_observation_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_unity_store.dart';

import 'package:omni_drug_control/omni_drug_control.dart' show DrugControlModule;
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/omni_measurement.dart' show MeasurementModule;
import 'package:omni_mediktor/omni_mediktor.dart' show MediktorDiagnosisStore, MediktorModule, MediktorRepository;
import 'package:omni_plan/omni_plan.dart' show OmniPlanModule;
import 'package:omni_scheduling/omni_scheduling.dart' show SchedulingModule;

class NewHomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => MediktorDiagnosisStore()),
    Bind.lazySingleton((i) => MediktorRepository(i.get<DioHttpClientImpl>())),
    Bind.lazySingleton((i) => ModuleCategoryStore()),
    Bind.lazySingleton((i) => OmniplanModuleIconStore()),
    Bind.lazySingleton((i) => UnreadNotificationsCountStore()),
    Bind.lazySingleton((i) => ProfileStore()),
    Bind.lazySingleton((i) => ZipCodeStore()),
    Bind.lazySingleton((i) => DrugControlHistoricStore()),
    Bind.lazySingleton((i) => DrugControlHistoricRepository(i.get<DioHttpClientImpl>())),
    Bind.lazySingleton((i) => BottomNavigationStore()),
    Bind.lazySingleton(
      (i) => NewDrugControlRepository(i.get<DioHttpClientImpl>()),
    ),
    Bind.lazySingleton((i) => NewDrugControlStore()),
    Bind.lazySingleton((i) => NewDrugControlUnityStore()),
    Bind.lazySingleton((i) => NewDrugControlDosageStore()),
    Bind.lazySingleton((i) => NewDrugControlMedicineStore()),
    Bind.lazySingleton((i) => NewDrugControlObservationStore()),
    Bind.lazySingleton((i) => NewDrugControlAdministrationStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
    ChildRoute(
      '/presentation',
      child: (_, args) => const HomePresentationPage(),
      transition: TransitionType.downToUp,
    ),
    ChildRoute(
      '/services',
      child: (_, args) => const ServicesPage(),
      transition: TransitionType.downToUp,
    ),
    ModuleRoute(
      '/new_consultation',
      module: NewConsultationModule(),
      transition: TransitionType.downToUp,
    ),
    ModuleRoute(
      '/drawer',
      module: DrawerModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/profile',
      module: NewProfileModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/settings',
      module: SettingsModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/bots',
      module: OmniBotModule(),
      transition: TransitionType.downToUp,
    ),
    ModuleRoute(
      '/mediktor',
      module: MediktorModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/notifications',
      module: NotificationsModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/schedulings',
      module: SchedulingModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/extraData',
      module: ExtraDataModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/informativesCategory',
      module: InformativesModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/drugControl',
      module: DrugControlModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/measurements',
      module: MeasurementModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/procedures',
      module: ProceduresModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/caregivers',
      module: CaregiversModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/omniPlan',
      module: OmniPlanModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/vaccines',
      module: VaccineModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/diseases',
      module: DiseasesModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/exams',
      module: ExamsModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/discounts',
      module: NewDiscountsModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/teleattendanceUrgency',
      module: TeleattendanceModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/reminders',
      module: RemindersModule(),
      // module: DrugControlModule(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
