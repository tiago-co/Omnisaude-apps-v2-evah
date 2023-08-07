import 'package:flutter/material.dart';
import 'package:omni_drug_control/src/core/enums/medicine_status_enum.dart';
import 'package:omni_drug_control/src/core/models/medicine_model.dart';

class DrugControlVerticalTimelineItemWidget extends StatelessWidget {
  final Widget child;
  final int index;
  final MedicineModel? medicine;
  const DrugControlVerticalTimelineItemWidget({
    Key? key,
    required this.child,
    required this.index,
    required this.medicine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Theme.of(context).cardColor.withOpacity(0.5),
              ),
            ),
          ),
          margin: const EdgeInsets.only(left: 10),
          padding: const EdgeInsets.only(left: 25, bottom: 20),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).cardColor.withOpacity(0.5),
                width: medicine!.consumido! ? 0.5 : 0,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: child,
              ),
            ),
          ),
        ),
        Positioned(
          left: 0.5,
          top: 30,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.background,
            ),
            width: 20,
            height: 20,
            child: medicine!.status!.getMedicineWidget,
          ),
        ),
      ],
    );
  }
}
