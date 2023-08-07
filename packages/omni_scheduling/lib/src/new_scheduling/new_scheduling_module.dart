import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_scheduling/src/new_scheduling/pages/new_scheduling_page.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/new_scheduling_category_store.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/new_scheduling_professional_store.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/new_scheduling_reason_store.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/new_scheduling_specialty_store.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/new_scheduling_store.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/scheduling_bottom_button_store.dart';
import 'package:omni_scheduling/src/shared/stores/scheduling_date_store.dart';
import 'package:omni_scheduling/src/shared/stores/scheduling_hour_store.dart';

class NewSchedulingModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => NewSchedulingStore()),
    Bind.lazySingleton((i) => SchedulingDateStore()),
    Bind.lazySingleton((i) => SchedulingHourStore()),
    Bind.lazySingleton((i) => NewSchedulingReasonStore()),
    Bind.lazySingleton((i) => NewSchedulingCategoryStore()),
    Bind.lazySingleton((i) => NewSchedulingSpecialtyStore()),
    Bind.lazySingleton((i) => NewSchedulingProfessionalStore()),
    Bind.lazySingleton((i) => SchedulingBottomButtonStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => NewSchedulingPage(
        schedulingType: args.data['schedulingType'],
        moduleName: args.data['moduleName'],
        beneficiaryId: args.data['beneficiaryId'],
        schedulingMode: args.data['schedulingMode'],
      ),
    ),
  ];
}
