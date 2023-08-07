import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NotificationItemShimmerWidget extends StatelessWidget {
  const NotificationItemShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).primaryColor.withOpacity(0.25),
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
        child: ListView.separated(
          itemCount: 20,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          separatorBuilder: (_, __) => const SizedBox(height: 15),
          itemBuilder: (_, index) {
            return _buildNotificationShimmerWidget(context);
          },
        ),
      ),
    );
  }

  Widget _buildNotificationShimmerWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.25),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.75),
                shape: BoxShape.circle,
              ),
              height: 40,
              width: 40,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.75),
                        ),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 15,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.75),
                      ),
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: 15,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.75),
                  ),
                  width: double.infinity,
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
