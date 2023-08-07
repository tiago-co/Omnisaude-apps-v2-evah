import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_measurement/src/core/enums/measurement_mode_enum.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';

class MeasurementModeToggleTypeWidget extends StatelessWidget {
  final MeasurementMode mode;
  final MeasurementModel model;
  final bool isActive;
  final Function(MeasurementModel, MeasurementMode) onTap;

  const MeasurementModeToggleTypeWidget({
    Key? key,
    required this.mode,
    required this.model,
    required this.onTap,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call(model, mode);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            width: 2,
          ),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.width * 0.225,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              mode.asset,
              height: 50,
              width: 50,
              package: 'omni_measurement',
              color: Theme.of(context).primaryColor.withOpacity(0.75),
            ),
            const SizedBox(width: 25),
            Text(
              mode.modeText.toString(),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).primaryColor,
                    height: 1.25,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
