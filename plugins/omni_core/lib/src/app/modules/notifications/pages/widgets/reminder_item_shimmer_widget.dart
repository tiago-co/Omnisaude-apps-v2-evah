import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ReminderItemShimmerWidget extends StatelessWidget {
  const ReminderItemShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).primaryColor.withOpacity(0.25),
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: List.generate(
              10,
              (index) => Padding(
                padding: EdgeInsets.only(left: index == 0 ? 0 : 15),
                child: _buildReminderShimmerWidget(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReminderShimmerWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(10),
      ),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 15,
                  width: double.infinity,
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 15,
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 40,
                  width: double.infinity,
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 100,
            width: 100,
          ),
        ],
      ),
    );
  }
}
