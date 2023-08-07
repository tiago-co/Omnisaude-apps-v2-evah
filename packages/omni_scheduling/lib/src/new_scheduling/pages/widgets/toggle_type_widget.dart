import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_scheduling/omni_scheduling.dart';

class ToggleTypeWidget extends StatelessWidget {
  final SchedulingType type;
  final NewSchedulingModel model;

  final bool isActive;
  final Function(NewSchedulingModel, SchedulingType) onTap;

  const ToggleTypeWidget({
    Key? key,
    required this.type,
    required this.model,
    this.isActive = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(model, type),
      borderRadius: BorderRadius.circular(10),
      splashColor: Theme.of(context).primaryColor.withOpacity(0.1),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.05),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
        ),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.width / 2.5,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              type.asset,
              width: 40,
              height: 40,
              color: Theme.of(context).primaryColor,
              package: AssetsPackage.omniScheduling,
            ),
            const SizedBox(height: 15),
            Text(
              type.label,
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
