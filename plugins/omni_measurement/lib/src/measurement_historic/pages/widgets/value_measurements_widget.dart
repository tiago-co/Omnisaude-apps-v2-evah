import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_measurement/omni_measurement.dart';
import 'package:omni_measurement/src/core/enums/measurement_mode_enum.dart';

class ValueMeasurementsWidget extends StatefulWidget {
  final String measurement;
  final MeasurementType measurementType;
  final MeasurementMode measurementMode;

  const ValueMeasurementsWidget({
    Key? key,
    required this.measurement,
    required this.measurementType,
    required this.measurementMode,
  }) : super(key: key);

  @override
  _ValueMeasurementsWidgetState createState() =>
      _ValueMeasurementsWidgetState();
}

class _ValueMeasurementsWidgetState extends State<ValueMeasurementsWidget> {
  final NewMeasurementStore store = Modular.get<NewMeasurementStore>();

  @override
  void initState() {
    if (widget.measurementType == MeasurementType.pressure) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Row(
        children: [
          Icon(
            widget.measurementMode == MeasurementMode.camera
                ? Icons.camera_alt_rounded
                : widget.measurementMode == MeasurementMode.automatic
                    ? Icons.bluetooth
                    : Icons.touch_app_rounded,
            color: Theme.of(context).colorScheme.background,
            size: 40,
          ),
          if (widget.measurementType != MeasurementType.pressure)
            Expanded(child: _buildGeneralMeasurementValueWidget)
          else
            Expanded(child: _buildPressureMeasurementValueWidget),
        ],
      ),
    );
  }

  Widget get _buildPressureMeasurementValueWidget {
    final int secondtBarIndex =
        widget.measurement.indexOf('/', widget.measurement.indexOf('/') + 1);
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.measurement.substring(0, secondtBarIndex),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.background,
                      fontSize: 42,
                    ),
              ),
              const SizedBox(width: 5),
              Text(
                widget.measurementType.deviceMeasurementType,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).colorScheme.background,
                      fontSize: 24,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              text: widget.measurement
                  .substring(secondtBarIndex + 1, widget.measurement.length),
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Theme.of(context).colorScheme.background,
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                TextSpan(
                  text: ' BPM',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                        fontSize: 14,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildGeneralMeasurementValueWidget {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            widget.measurement,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.background,
                  fontSize: 55,
                ),
          ),
          Text(
            widget.measurementType.deviceMeasurementType,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.background,
                  fontSize: 24,
                ),
          ),
        ],
      ),
    );
  }
}
