import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement_labels/labels.dart';

class EnableBluetoothWidget extends StatefulWidget {
  const EnableBluetoothWidget({Key? key}) : super(key: key);

  @override
  State<EnableBluetoothWidget> createState() => _EnableBluetoothWidgetState();
}

class _EnableBluetoothWidgetState extends State<EnableBluetoothWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 15),
          Expanded(
            child: BuildAssetsWidget(
              message: Text(
                MeasurementLabels.enableBluetoothActive,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      // fontWeight: FontWeight.w600,
                    ),
              ),
              assetBase: 'assets/alert/alert_one.svg',
              asset: 'assets/alert/alert_two.svg',
            ),
          ),
          const SizedBox(height: 15),
          BottomButtonWidget(
            isBottomSafe: false,
            onPressed: () {
              Modular.to.pop();
              Helpers.checkDevicebluetoothIsOn().then(
                (value) {
                  if (!value) {
                    Modular.to.pop();
                  }
                },
              );
            },
            text: MeasurementLabels.enableBluetoothContinue,
          ),
        ],
      ),
    );
  }
}
