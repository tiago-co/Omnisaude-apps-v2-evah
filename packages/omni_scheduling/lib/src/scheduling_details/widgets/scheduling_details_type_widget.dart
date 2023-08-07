import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_type_enum.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingDetailsTypeWidget extends StatelessWidget {
  final SchedulingModel scheduling;
  final String? typeScheduling;

  const SchedulingDetailsTypeWidget({
    Key? key,
    required this.scheduling,
    this.typeScheduling,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          SvgPicture.asset(
            scheduling.type == SchedulingType.presential
                ? Assets.presential
                : Assets.teleattendance,
            package: AssetsPackage.omniScheduling,
            color: Theme.of(context).primaryColor,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  SchedulingLabels.schedulingDetailsTypAttendenceType,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  typeScheduling ??
                      scheduling.type?.label ??
                      SchedulingLabels.schedulingDetailsTypeEmpty,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
