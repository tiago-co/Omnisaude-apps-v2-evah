import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement_labels/labels.dart';

class BluetoothOffStateWidget extends StatefulWidget {
  const BluetoothOffStateWidget({Key? key, this.state}) : super(key: key);

  final BluetoothAdapterState? state;

  @override
  State<BluetoothOffStateWidget> createState() =>
      _BluetoothOffStateWidgetState();
}

class _BluetoothOffStateWidgetState extends State<BluetoothOffStateWidget> {
  @override
  Widget build(BuildContext context) {
    String state = '';
    widget.state != null
        ? widget.state.toString().substring(15) == 'off'
            ? state = MeasurementLabels.bluetoothOffStateOff
            : state = MeasurementLabels.bluetoothOffStateOn
        : state = MeasurementLabels.bluetoothOffStateNotIdentified;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.bluetooth_disabled,
          size: 150.0,
          color: Theme.of(context).cardColor.withOpacity(0.6),
        ),
        const SizedBox(height: 20),
        Text(
          '${MeasurementLabels.bluetoothOffStateBluetooth} $state',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 20),
        Text(
          MeasurementLabels.bluetoothOffStateToContinue,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 20),
        if (Platform.isAndroid)
          RoundedButtonWidget(
            text: MeasurementLabels.bluetoothOffStateActiveBluetooth,
            onPressed:
                Platform.isAndroid ? () => FlutterBluePlus.turnOn() : null,
            buttonType: DefaultButtonType.outline,
          )
      ],
    );
  }
}
