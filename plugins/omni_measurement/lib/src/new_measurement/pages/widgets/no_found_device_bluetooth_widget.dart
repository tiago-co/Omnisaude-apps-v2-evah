// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/src/new_measurement/stores/new_measurement_store.dart';
import 'package:omni_measurement_labels/labels.dart';

class NoFoundDeviceBluettohWidget extends StatefulWidget {
  String? text;
  NoFoundDeviceBluettohWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<NoFoundDeviceBluettohWidget> createState() =>
      _NoFoundDeviceBluettohWidgetState();
}

class _NoFoundDeviceBluettohWidgetState
    extends State<NoFoundDeviceBluettohWidget> {
  NewMeasurementStore store = Modular.get<NewMeasurementStore>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              MeasurementLabels.noFoundDeviceBluetoothOps,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
            ),
            Stack(
              children: [
                SvgPicture.asset(
                  'assets/alert_automatic/alert_measure_automatic_base.svg',
                  package: 'omni_measurement',
                  width: 170,
                ),
                SvgPicture.asset(
                  'assets/alert_automatic/alert_measure_automatic_color.svg',
                  package: 'omni_measurement',
                  width: 170,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            Text(
              widget.text!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 15),
            RoundedButtonWidget(
              text: MeasurementLabels.noFoundDeviceBluetoothAddDevice,
              borderRadius: 25,
              onPressed: () async {
                await Future.delayed(const Duration(milliseconds: 250));
                Modular.to.pushReplacementNamed(
                  '/home/drawer/my_devices/',
                  arguments: store.state.measurementType,
                );
              },
              buttonType: DefaultButtonType.outline,
            ),
          ],
        ),
      ),
    );
  }
}
