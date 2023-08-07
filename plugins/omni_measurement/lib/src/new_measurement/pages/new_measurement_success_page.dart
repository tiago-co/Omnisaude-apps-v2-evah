import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_measurement/omni_measurement.dart';
import 'package:omni_measurement_labels/labels.dart';

class NewMeasurementSuccessPage extends StatelessWidget {
  final NewMeasurementStore store = Modular.get();

  NewMeasurementSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/sucesso_medicao.svg',
            package: 'omni_measurement',
            height: 200,
          ),
          const SizedBox(height: 25),
          Text(
            MeasurementLabels.newMeasurementSuccessCongratulations,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '${MeasurementLabels.newMeasurementSuccessYourMeasurement} ${store.state.measurementType!.typeOfMonitoring} '
              '${MeasurementLabels.newMeasurementSuccessSent}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}
