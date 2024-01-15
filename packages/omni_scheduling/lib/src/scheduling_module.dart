import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/core/repositories/scheduling_repository.dart';
import 'package:omni_scheduling/src/new_consultation/new_consultation_module.dart';
import 'package:omni_scheduling/src/new_scheduling/new_scheduling_module.dart';
import 'package:omni_scheduling/src/scheduling_details/scheduling_details_module.dart';
import 'package:omni_scheduling/src/scheduling_historic/scheduling_historic_page.dart';
import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_date_filter_store.dart';
import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_historic_store.dart';
import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_professional_filter_store.dart';
import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_specialty_filter_store.dart';
import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_status_filter_store.dart';
import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_type_filter_store.dart';
import 'package:omni_video_call/omni_video_call.dart';

class SchedulingModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SchedulingHistoricStore()),
    Bind.lazySingleton((i) => VideoCallStore()),
    Bind.lazySingleton((i) => SchedulingTypeFilterStore()),
    Bind.lazySingleton((i) => SchedulingDateFilterStore()),
    Bind.lazySingleton((i) => SchedulingStatusFilterStore()),
    Bind.lazySingleton((i) => SchedulingSpecialtyFilterStore()),
    Bind.lazySingleton((i) => SchedulingRepository(i.get<DioHttpClientImpl>())),
    Bind.lazySingleton((i) => SchedulingProfessionalFilterStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    // ChildRoute(
    //   '/historic',
    //   child: (_, args) => SchedulingHistoricPage(
    //     moduleName: args.data['moduleName'],
    //     beneficiaryId: args.data['beneficiaryId'],
    //     schedulingType: args.data['schedulingType'],
    //     schedulingModeModel: args.data['schedulingModeModel'],
    //   ),
    //   transition: TransitionType.fadeIn,
    // ),
    ModuleRoute(
      '/historic',
      module: NewConsultationModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/newScheduling',
      module: NewSchedulingModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/schedulingDetails',
      module: SchedulingDetailsModule(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
