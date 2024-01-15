import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/pages/coupon_details_page.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/pages/cupons_page.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/pages/discounts_page.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/pages/scan_qrcode_page.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/pages/select_rescue_type_page.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/pages/success_coupon_rescue_page.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/coupon_details_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/coupon_rescue_type_filter_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/organizations_list_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/rescue_coupon_store.dart';
import 'package:omni_core/src/app/modules/new_discounts/discount_detail.dart';
import 'package:omni_core/src/app/modules/new_discounts/new_cupons_page.dart';
import 'package:omni_core/src/app/modules/new_discounts/new_discounts_page.dart';
import 'package:omni_core/src/app/modules/new_reminders/reminder_page.dart';
import 'package:omni_core/src/app/modules/new_reminders/repository/drug_control_historic_repository.dart';
import 'package:omni_core/src/app/modules/new_reminders/repository/new_drug_control_repository.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/drug_control_historic_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_administration_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_dosage_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_medicine_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_observation_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_unity_store.dart';
import 'package:omni_general/omni_general.dart';

class RemindersModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => NewDrugControlRepository(i.get<DioHttpClientImpl>()),
    ),
    Bind.lazySingleton(
      (i) => DrugControlHistoricRepository(i.get<DioHttpClientImpl>()),
    ),
    Bind.lazySingleton((i) => NewDrugControlStore()),
    Bind.lazySingleton((i) => NewDrugControlUnityStore()),
    Bind.lazySingleton((i) => NewDrugControlDosageStore()),
    Bind.lazySingleton((i) => NewDrugControlMedicineStore()),
    Bind.lazySingleton((i) => NewDrugControlObservationStore()),
    Bind.lazySingleton((i) => NewDrugControlAdministrationStore()),
    Bind.lazySingleton((i) => DrugControlHistoricStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => ReminderPage(
          // moduleName: args.data['moduleName'],
          // categoryParam: args.data['categoryParam'],
          ),
    ),
    // ChildRoute(
    //   '/discounts',
    //   child: (_, args) => NewDiscountsPage(
    //     moduleName: args.data['moduleName'],
    //     categoryParam: args.data['categoryParam'],
    //   ),
    // ),
    // ChildRoute(
    //   '/cupons',
    //   child: (_, args) => NewCuponsPage(
    //       organizationId: args.data['organizationId'],
    //       moduleName: args.data['moduleName'],
    //       coverImage: args.data['coverImage'],
    //       couponRescueType: args.data['couponRescueType'],
    //       categoryParam: args.data['categoryParam']),
    // ),
    // ChildRoute(
    //   '/coupon_details',
    //   child: (_, args) => CouponDetailsPage(
    //     title: args.data,
    //   ),
    // ),
    // ChildRoute(
    //   '/discount_details',
    //   child: (_, args) => DiscountDetail(
    //     organizationId: args.data['organizationId'],
    //   ),
    // ),
    // ChildRoute(
    //   '/scan_qrcode',
    //   child: (_, args) => const ScanQrcodePage(),
    // ),
    // ChildRoute(
    //   '/success_page',
    //   child: (_, args) => SuccessCouponRescuePage(
    //     coupon: args.data['coupon'],
    //     organizationId: args.data['organizationId'],
    //   ),
    // ),
  ];
}
