import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeModulesGroupShimmerWidget extends StatelessWidget {
  const HomeModulesGroupShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).primaryColor.withOpacity(0.25),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
      child: ListView.separated(
        itemCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        separatorBuilder: (_, index) => const SizedBox(height: 40),
        itemBuilder: (_, index) {
          return _buildCategoryWidget(context);
        },
      ),
    );
  }

  Widget _buildCategoryWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 20,
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
              ],
            ),
          ),
          const SizedBox(width: 25),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            height: 90,
            width: 90,
            padding: const EdgeInsets.all(10),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
