import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SchedulingDetailsActionsShimmerWidget extends StatelessWidget {
  const SchedulingDetailsActionsShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).primaryColor.withOpacity(0.25),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            _buildActionItem(context),
            _buildActionItem(context),
            _buildActionItem(context),
            _buildActionItem(context, isLast: true),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(BuildContext _, {bool isLast = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(_).colorScheme.background.withOpacity(0.25),
      ),
      margin: EdgeInsets.only(right: isLast ? 0 : 10),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(_).colorScheme.background,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 15,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(_).colorScheme.background,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 15,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(_).colorScheme.background,
            ),
          ),
        ],
      ),
    );
  }
}
