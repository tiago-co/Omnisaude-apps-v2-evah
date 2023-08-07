import 'package:flutter/material.dart';
import 'package:omni_scheduling/omni_scheduling.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_step_enum.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingProgressWidget extends StatefulWidget {
  final int step;
  final double progress;
  final String nextTitle;
  final SchedulingStepType type;
  final SchedulingModeType modeType;

  const SchedulingProgressWidget({
    Key? key,
    required this.step,
    required this.type,
    required this.progress,
    required this.nextTitle,
    required this.modeType,
  }) : super(key: key);

  @override
  _SchedulingProgressWidgetState createState() =>
      _SchedulingProgressWidgetState();
}

class _SchedulingProgressWidgetState extends State<SchedulingProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColor,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Text(
                  SchedulingLabels.schedulingProgressSchedulingData,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
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
                              value: widget.progress,
                              strokeWidth: 5,
                              color: Theme.of(context).primaryColor,
                              backgroundColor:
                                  Theme.of(context).cardColor.withOpacity(0.1),
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
                                widget.modeType != SchedulingModeType.mediktor
                                    ? '${widget.step} / 3'
                                    : '${widget.step} / 2',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Expanded(child: _buildSchedulingDescription),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget get _buildSchedulingDescription {
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
          widget.nextTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
