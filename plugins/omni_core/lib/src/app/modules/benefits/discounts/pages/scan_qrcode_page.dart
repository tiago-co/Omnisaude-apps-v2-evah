import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/coupon_details_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/rescue_coupon_store.dart';
import 'package:omni_general/omni_general.dart';

class ScanQrcodePage extends StatefulWidget {
  const ScanQrcodePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ScanQrcodePage> createState() => _ScanQrcodePageState();
}

class _ScanQrcodePageState extends State<ScanQrcodePage> {
  final CouponDetailsStore store = Modular.get();
  final RescueCouponStore rescueCouponStore = Modular.get();

  final MobileScannerController controller = MobileScannerController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) async {
          if (capture.barcodes.first.rawValue != null) {
            final String qrCodeInformation = capture.barcodes.first.rawValue!;
            final int cnpjStartOnString = qrCodeInformation.indexOf(':');
            final cpnj = qrCodeInformation.substring(
              cnpjStartOnString + 2,
              qrCodeInformation.length - 2,
            );
            await Modular.to.pushReplacementNamed(
              'success_page',
              arguments: {
                'coupon': RescueCouponModel(
                  confirmationKey: cpnj,
                  couponId: store.state.id,
                ),
                'organizationId': store.state.organizationId,
              },
            );
          }
        },
      ),
    );
  }
}
