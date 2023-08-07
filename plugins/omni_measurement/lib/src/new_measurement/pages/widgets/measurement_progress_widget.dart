import 'package:flutter/material.dart';
import 'package:omni_measurement/src/core/enums/measurement_step_type_enum.dart';
import 'package:omni_measurement_labels/labels.dart';

class MeasurementProgressWidget extends StatefulWidget {
  final int step;
  final double quantitySteps;
  final String nextTitle;
  final MeasurementStepType type;

  const MeasurementProgressWidget({
    Key? key,
    required this.step,
    required this.type,
    required this.quantitySteps,
    required this.nextTitle,
  }) : super(key: key);

  @override
  _MeasurementProgressWidgetState createState() =>
      _MeasurementProgressWidgetState();
}

class _MeasurementProgressWidgetState extends State<MeasurementProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.step < widget.quantitySteps + 1
        ? Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 25,
                  bottom: 15,
                  left: 25,
                  right: 25,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: SizedBox(
                              width: 75,
                              height: 75,
                              child: CircularProgressIndicator(
                                value: (1 / widget.quantitySteps) * widget.step,
                                strokeWidth: 5,
                                valueColor: AlwaysStoppedAnimation(
                                  Theme.of(context).primaryColor,
                                ),
                                backgroundColor: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.1),
                              ),
                            ),
                          ),
                          Center(
                            child: ClipOval(
                              child: Container(
                                width: 75,
                                height: 75,
                                alignment: Alignment.center,
                                child: Text(
                                  // widget.step != 5
                                  '${widget.step} ${MeasurementLabels.measurementProgressTotalSteps}',
                                  // : '${widget.step-1} / 4',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Expanded(child: _buildMeasurementDescription),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Divider(
                  color: Theme.of(context).cardColor.withOpacity(0.5),
                  thickness: 1,
                ),
              ),
            ],
          )
        : Container();
  }

  Widget get _buildMeasurementDescription {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.type.label,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          '${MeasurementLabels.measurementProgressNext} ${widget.nextTitle}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
