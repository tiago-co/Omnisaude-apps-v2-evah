import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class InformativeItemShimmerWidget extends StatelessWidget {
  const InformativeItemShimmerWidget({Key? key}) : super(key: key);

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
              (index) => _buildInformativeItemShimmerWidget(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInformativeItemShimmerWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 15,
            width: double.infinity,
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.width / 3,
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 15,
            width: MediaQuery.of(context).size.width * 0.4,
          ),
        ],
      ),
    );
  }
}
