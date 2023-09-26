import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class InformativeCategoryItemShimmerWidget extends StatelessWidget {
  const InformativeCategoryItemShimmerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).primaryColor.withOpacity(0.25),
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: List.generate(
              10,
              (index) => _buildInformativeCategoryItemShimmerWidget(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInformativeCategoryItemShimmerWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.5),
      ),
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 15,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
