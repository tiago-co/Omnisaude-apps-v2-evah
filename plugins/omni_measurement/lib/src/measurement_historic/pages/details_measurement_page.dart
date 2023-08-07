import 'package:flutter/material.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';

import 'package:omni_measurement/src/measurement_historic/pages/widgets/measurement_details_body_widget.dart';
import 'package:omni_measurement/src/measurement_historic/pages/widgets/value_measurements_widget.dart';
import 'package:omni_measurement_labels/labels.dart';

class DetailsMeasurementPage extends StatelessWidget {
  final MeasurementModel measurement;
  const DetailsMeasurementPage({
    Key? key,
    required this.measurement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: MeasurementLabels.detailsMeasurementTitle,
      ).build(context) as AppBar,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          ValueMeasurementsWidget(
                            measurement: measurement.currentMeasure ??
                                MeasurementLabels
                                    .detailsMeasurementNoCurrentMeasure,
                            measurementType: measurement.measurementType!,
                            measurementMode: measurement.measurementMode!,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    MeasurementDetailsBodyWidget(measurement: measurement)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
