import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ReimbursementListShimmerWidget extends StatelessWidget {
  const ReimbursementListShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).primaryColor.withOpacity(0.25),
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
        child: ListView.separated(
          itemCount: 20,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          separatorBuilder: (_, __) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: SizedBox(),
          ),
          itemBuilder: (_, index) {
            return _buildReimbursementListShimmerWidget;
          },
        ),
      ),
    );
  }

  Widget get _buildReimbursementListShimmerWidget {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 15,
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 15,
          ),
          const Divider(),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 15,
                width: 15,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 15,
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
