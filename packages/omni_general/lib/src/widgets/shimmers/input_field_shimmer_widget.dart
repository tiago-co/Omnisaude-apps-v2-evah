import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class InputFieldShimmerWidget extends StatelessWidget {
  final double width;
  final double height;

  const InputFieldShimmerWidget({
    Key? key,
    this.width = double.infinity,
    this.height = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white.withOpacity(0.5),
      ),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.background.withOpacity(0.25),
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          height: height,
          width: width,
        ),
      ),
    );
  }
}
