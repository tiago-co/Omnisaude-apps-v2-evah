import 'package:flutter/material.dart';
import 'package:omni_general/omni_general.dart';
import 'package:shimmer/shimmer.dart';

class CaregiverItemShimmerWidget extends StatelessWidget {
  const CaregiverItemShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).primaryColor.withOpacity(0.25),
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: List.generate(
              10,
              (index) => const VerticalTimelineItemShimmerWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
