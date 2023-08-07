// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general_labels/labels.dart';

class NoDevicesFoundWidget extends StatefulWidget {
  final String? text;
  const NoDevicesFoundWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<NoDevicesFoundWidget> createState() => _NoDevicesFoundWidgetState();
}

class _NoDevicesFoundWidgetState extends State<NoDevicesFoundWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          GeneralLabels.bluetoothNoDeviceFoundText,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
        ),
        Stack(
          children: [
            SvgPicture.asset(
              Assets.alertMeasureAutomaticBase,
              package: AssetsPackage.omniMeasurement,
              width: 200,
            ),
            SvgPicture.asset(
              Assets.alertMeasureAutomaticColor,
              package: AssetsPackage.omniMeasurement,
              width: 200,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
        Text(
          widget.text!,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
