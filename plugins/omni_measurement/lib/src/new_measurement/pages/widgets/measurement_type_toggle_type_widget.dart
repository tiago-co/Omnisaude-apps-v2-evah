import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_measurement/src/core/enums/measurement_type_enum.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';

class MeasurementTypeToggleWidget extends StatelessWidget {
  final MeasurementType type;
  final MeasurementModel form;
  final bool isActive;
  final Function(MeasurementModel, MeasurementType) onTap;
  const MeasurementTypeToggleWidget({
    Key? key,
    required this.type,
    required this.form,
    required this.onTap,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(form, type),
      borderRadius: BorderRadius.circular(10),
      splashColor: Theme.of(context).primaryColor.withOpacity(0.1),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.05),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.all(30),
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: SvgPicture.asset(
                type.asset,
                width: 40,
                height: 40,
                color: Theme.of(context).primaryColor,
                package: 'omni_measurement',
              ),
            ),
            const SizedBox(height: 5),
            Text(
              type.label.toString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
