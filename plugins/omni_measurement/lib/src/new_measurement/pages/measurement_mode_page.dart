import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_measurement/omni_measurement.dart';

import 'package:omni_measurement/src/core/enums/measurement_mode_enum.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';
import 'package:omni_measurement/src/new_measurement/pages/widgets/measurement_mode_toogle_type_widget.dart';
import 'package:omni_measurement/src/new_measurement/stores/bottom_button_store.dart';
import 'package:omni_measurement_labels/labels.dart';

class MeasurementModePage extends StatefulWidget {
  final PageController pageController;
  final Function(MeasurementModel, MeasurementMode) nextOrCreateMeasurement;

  const MeasurementModePage({
    Key? key,
    required this.pageController,
    required this.nextOrCreateMeasurement,
  }) : super(key: key);

  @override
  _MeasurementModePageState createState() => _MeasurementModePageState();
}

class _MeasurementModePageState extends State<MeasurementModePage> {
  final NewMeasurementStore store = Modular.get();
  final BottomButtonStore bottomButtonStore = Modular.get();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                MeasurementLabels.measurementModeDescription,
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TripleBuilder<NewMeasurementStore, Exception, MeasurementModel>(
                store: store,
                builder: (_, triple) {
                  return Column(
                    children: [
                      if (store.state.measurementType !=
                          MeasurementType.temperature)
                        MeasurementModeToggleTypeWidget(
                          model: store.state,
                          isActive: triple.state.measurementMode ==
                              MeasurementMode.automatic,
                          mode: MeasurementMode.automatic,
                          onTap: widget.nextOrCreateMeasurement,
                        ),
                      if (store.state.measurementType ==
                          MeasurementType.glucose)
                        MeasurementModeToggleTypeWidget(
                          model: store.state,
                          isActive: triple.state.measurementMode ==
                              MeasurementMode.camera,
                          mode: MeasurementMode.camera,
                          onTap: widget.nextOrCreateMeasurement,
                        ),
                      MeasurementModeToggleTypeWidget(
                        model: store.state,
                        isActive: triple.state.measurementMode ==
                            MeasurementMode.manual,
                        mode: MeasurementMode.manual,
                        onTap: widget.nextOrCreateMeasurement,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
