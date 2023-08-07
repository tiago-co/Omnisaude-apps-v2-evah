import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_measurement/src/core/enums/feeling_type_enum.dart';

class HowAreYouFeelingTypeWidget extends StatelessWidget {
  final AreYouFeeling type;
  final Icon icon;
  final bool isActive;
  final Function(AreYouFeeling) onTap;
  const HowAreYouFeelingTypeWidget({
    Key? key,
    required this.type,
    required this.isActive,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(type),
      borderRadius: BorderRadius.circular(10),
      splashColor: Theme.of(context).primaryColor.withOpacity(0.1),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              type.asset,
              height: 60,
              color: isActive
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).cardColor,
              package: 'omni_measurement',
            ),
            const SizedBox(height: 15),
            Text(
              type.label,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: isActive ? FontWeight.w600 : null,
                    color: isActive
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).cardColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
