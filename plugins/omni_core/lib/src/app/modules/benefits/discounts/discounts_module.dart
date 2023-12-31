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

class DiscountsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => OrganizationsListStore()),
    Bind.lazySingleton((i) => CouponRescueTypeFilterStore()),
    Bind.lazySingleton((i) => CouponDetailsStore()),
    Bind.lazySingleton((i) => RescueCouponStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => SelectRecueTypePage(
        moduleName: args.data['moduleName'],
        categoryParam: args.data['categoryParam'],
      ),
    ),
    ChildRoute(
      '/discounts',
      child: (_, args) => DiscountsPage(
        moduleName: args.data['moduleName'],
        categoryParam: args.data['categoryParam'],
      ),
    ),
    ChildRoute(
      '/cupons',
      child: (_, args) => CuponsPage(
        organizationId: args.data['organizationId'],
        moduleName: args.data['moduleName'],
        coverImage: args.data['coverImage'],
        couponRescueType: args.data['couponRescueType'],
      ),
    ),
    ChildRoute(
      '/coupon_details',
      child: (_, args) => CouponDetailsPage(
        title: args.data,
      ),
    ),
    ChildRoute(
      '/scan_qrcode',
      child: (_, args) => const ScanQrcodePage(),
    ),
    ChildRoute(
      '/success_page',
      child: (_, args) => SuccessCouponRescuePage(
        coupon: args.data['coupon'],
        organizationId: args.data['organizationId'],
      ),
    ),
  ];
}
