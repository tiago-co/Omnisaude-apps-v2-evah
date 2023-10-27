import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/core/enums/coupon_rescue_enum.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/coupon_details_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/coupon_rescue_type_filter_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/rescue_coupon_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:url_launcher/url_launcher.dart';

enum CouponTemplateType { link, qrCode, couponCode, linkAndCode, general, physicalCouponCode }

extension CouponTemplateTypeExtension on CouponTemplateType {
  String get buttonLabel {
    switch (this) {
      case CouponTemplateType.link:
        return 'Ir para site';
      case CouponTemplateType.qrCode:
        return 'Ler QRCode';
      case CouponTemplateType.couponCode:
        return 'Copiar cupom';
      case CouponTemplateType.linkAndCode:
        return 'Copiar cupom e ir para site';
      case CouponTemplateType.general:
        return '';
      case CouponTemplateType.physicalCouponCode:
        return 'Gerar QRCode';
    }
  }

  Function(BuildContext context, CouponDetailsStore cuponDetailStore) get getOnTapFloatingButton {
    // final CouponDetailsStore store = cuponDetailStore;
    final RescueCouponStore rescueCouponStore = Modular.get();

    switch (this) {
      case CouponTemplateType.link:
        return (context, store) async {
          await launchUrl(
            Uri.parse(store.state.activationUrl!),
          );
        };
      case CouponTemplateType.qrCode:
        return (context, store) {
          Modular.to.pushNamed('scan_qrcode', arguments: store.state.id);
        };
      case CouponTemplateType.couponCode:
        return (context, store) {
          rescueCouponStore
              .rescueCoupon(
            organizationId: store.state.organizationId!,
            rescueCoupon: RescueCouponModel(
              couponId: store.state.id,
            ),
          )
              .then((value) {
            final ClipboardData clipboardData = ClipboardData(text: store.state.code!);
            Clipboard.setData(clipboardData);
            Helpers.showDialog(
              context,
              SuccessWidget(
                onPressed: () => Modular.to.pop(),
                message: 'Cupom copiado com sucesso',
                buttonText: 'Voltar',
              ),
              showClose: true,
            );
          }).catchError((onError) {
            Helpers.showDialog(
              context,
              RequestErrorWidget(
                onPressed: () => Modular.to.pop(),
                message: 'Erro ao resgatar cupom',
                buttonText: 'Voltar',
              ),
              showClose: true,
            );
          });
        };
      case CouponTemplateType.linkAndCode:
        return (context, store) async {
          final ClipboardData clipboardData = ClipboardData(text: store.state.code!);
          Clipboard.setData(clipboardData);
          await launchUrl(
            Uri.parse(store.state.activationUrl!),
          );
        };
      case CouponTemplateType.general:
        return (context, store) async {};
      case CouponTemplateType.physicalCouponCode:
        return (context, store) async {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            enableDrag: true,
            isScrollControlled: true,
            useSafeArea: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: QrCodeWidget(code: store.state.code!),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        };
    }
  }
}

CouponTemplateType? couponTemplateTypeFromJson(String? template, String? code) {
  final CouponRescueTypeFilterStore couponRescueTypeFilterStore = Modular.get();
  switch (template) {
    case 'link':
      if (code == null || code.isEmpty) {
        return CouponTemplateType.link;
      } else {
        return CouponTemplateType.linkAndCode;
      }
    case 'coupon_code':
      if (couponRescueTypeFilterStore.state == CouponRescueType.physical) {
        return CouponTemplateType.physicalCouponCode;
      }
      return CouponTemplateType.couponCode;

    case 'qrcode':
      return CouponTemplateType.qrCode;
    case 'default':
      return CouponTemplateType.general;
    default:
      return null;
  }
}
