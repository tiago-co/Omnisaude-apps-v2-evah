import 'package:flutter/material.dart';

class VerticalTimelineItemWidget extends StatelessWidget {
  final Widget child;

  const VerticalTimelineItemWidget({
    Key? key,
    required this.child,
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
          margin: const EdgeInsets.only(left: 10),
          padding: const EdgeInsets.only(left: 25, bottom: 20),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).cardColor.withOpacity(0.5),
                width: 0.5,
              ),
              color: Theme.of(context).colorScheme.background,
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
          top: 20,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).primaryColor),
              color: Theme.of(context).primaryColor,
            ),
            width: 20,
            height: 20,
          ),
        ),
      ],
    );
  }
}
