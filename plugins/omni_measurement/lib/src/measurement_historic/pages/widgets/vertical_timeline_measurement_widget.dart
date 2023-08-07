import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_measurement/omni_measurement.dart';

class VerticalTimelineMeasurementWidget extends StatelessWidget {
  final Widget child;
  final MeasurementType measurementType;

  const VerticalTimelineMeasurementWidget({
    Key? key,
    required this.child,
    required this.measurementType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
          margin: const EdgeInsets.only(
            left: 25,
          ),
          padding: const EdgeInsets.only(left: 25, bottom: 15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: child,
            ),
          ),
        ),
        Positioned(
          left: 7.5,
          top: 10,
          child: Container(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).primaryColor),
              color: Colors.white,
            ),
            child: Center(
              child: SvgPicture.asset(
                measurementType.asset,
                package: 'omni_measurement',
                width: 22.5,
                height: 22.5,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
