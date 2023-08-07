import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_measurement_labels/labels.dart';

class LoadingGetMeasureWidget extends StatefulWidget {
  const LoadingGetMeasureWidget({Key? key}) : super(key: key);

  @override
  State<LoadingGetMeasureWidget> createState() =>
      _LoadingGetMeasureWidgetState();
}

class _LoadingGetMeasureWidgetState extends State<LoadingGetMeasureWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
                strokeWidth: 3,
              ),
            ),
            SvgPicture.asset(
              'assets/icons/ble_get_measure/ble_loading_base.svg',
              package: 'omni_measurement',
              width: 70,
            ),
            SvgPicture.asset(
              'assets/icons/ble_get_measure/ble_loading_color.svg',
              color: Theme.of(context).primaryColor,
              package: 'omni_measurement',
              width: 70,
            ),
          ],
        ),
        const SizedBox(height: 35.0),
        Text(
          MeasurementLabels.loadingGetMeasureWait,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        ),
        const SizedBox(height: 20),
        Text(
          MeasurementLabels.loadingGetMeasureGetting,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
