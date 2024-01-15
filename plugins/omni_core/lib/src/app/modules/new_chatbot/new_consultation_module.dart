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
import 'package:omni_core/src/app/modules/new_chatbot/chatbot_webview.dart';
import 'package:omni_core/src/app/modules/new_consultation/calendly_webview.dart';
import 'package:omni_core/src/app/modules/new_consultation/new_consultation_page.dart';
import 'package:omni_core/src/app/modules/new_discounts/discount_detail.dart';
import 'package:omni_core/src/app/modules/new_discounts/new_cupons_page.dart';
import 'package:omni_core/src/app/modules/new_discounts/new_discounts_page.dart';

class NewChatBotModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => ChatbotWebview(),
    ),
    // ChildRoute(
    //   '/calendly_webview',
    //   child: (_, args) => CalendlyWebview(),
    // ),
  ];
}
