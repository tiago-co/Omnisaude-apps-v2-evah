import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SchedulingDetailsFieldShimmerWidget extends StatelessWidget {
  const SchedulingDetailsFieldShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).primaryColor.withOpacity(0.25),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildInputFieldItemWidget(context, 0.4, 0.3),
          _buildInputFieldItemWidget(context, 0.3, 0.35),
          _buildInputFieldItemWidget(context, 0.35, 0.15),
          _buildInputFieldItemWidget(context, 0.2, 0.4),
          _buildInputFieldItemWidget(context, 0.3, 0.3),
        ],
      ),
    );
  }

  Widget _buildInputFieldItemWidget(BuildContext _, double w1, double w2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: _buildInputFieldWidget(_, w1),
              ),
              const SizedBox(width: 15),
              Flexible(
                child: _buildInputFieldWidget(_, w2),
              ),
            ],
          ),
        ),
        Divider(color: Theme.of(_).cardColor),
      ],
    );
  }

  Widget _buildInputFieldWidget(BuildContext _, double w) {
    return Container(
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(_).colorScheme.background,
      ),
      width: MediaQuery.of(_).size.width * w,
    );
  }
}
