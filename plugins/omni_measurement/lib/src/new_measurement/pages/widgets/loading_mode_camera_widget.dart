import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_measurement_labels/labels.dart';

class LoadingModeCameraWidget extends StatefulWidget {
  const LoadingModeCameraWidget({Key? key}) : super(key: key);

  @override
  State<LoadingModeCameraWidget> createState() =>
      _LoadingModeCameraWidgetState();
}

class _LoadingModeCameraWidgetState extends State<LoadingModeCameraWidget> {
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
              'assets/icons/ocr_loading/ocr-recognition.svg',
              package: 'omni_measurement',
              color: Theme.of(context).primaryColor,
              height: 80,
              width: 80,
            ),
            SvgPicture.asset(
              'assets/icons/ocr_loading/camera.svg',
              color: Theme.of(context).primaryColor,
              package: 'omni_measurement',
              height: 25,
              width: 25,
            ),
          ],
        ),
        const SizedBox(height: 35.0),
        Text(
          MeasurementLabels.loadingModeCameraWait,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        ),
        const SizedBox(height: 20),
        Text(
          MeasurementLabels.loadingModeCameraRecognizing,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
