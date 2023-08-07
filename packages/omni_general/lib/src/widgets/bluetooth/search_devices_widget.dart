import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/src/widgets/animation/ripple_animation.dart';
import 'package:omni_general_labels/labels.dart';

class ScanDevicesBluetoothWidget extends StatefulWidget {
  final String text;
  const ScanDevicesBluetoothWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ScanDevicesBluetoothWidget> createState() =>
      _ScanDevicesBluetoothWidgetState();
}

class _ScanDevicesBluetoothWidgetState
    extends State<ScanDevicesBluetoothWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RippleAnimation(
            color: Theme.of(context).primaryColor,
            minRadius: 75,
            child: SingleChildScrollView(
              child: Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        Assets.iconSearchDeviceBase,
                        package: AssetsPackage.omniMeasurement,
                        width: 90,
                      ),
                      SvgPicture.asset(
                        Assets.iconSearchDeviceColor,
                        package: AssetsPackage.omniMeasurement,
                        color: Theme.of(context).primaryColor,
                        width: 90,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 45.0),
          Text(
           GeneralLabels.bluetoothSearchDevicesText,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.text,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
