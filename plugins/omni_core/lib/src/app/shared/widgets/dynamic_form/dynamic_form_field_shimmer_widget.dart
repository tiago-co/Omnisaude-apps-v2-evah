import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DynamicFormFieldShimmerWidget extends StatelessWidget {
  const DynamicFormFieldShimmerWidget({Key? key}) : super(key: key);

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
              20,
              (index) => _buildFieldItemShimmerWidget(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldItemShimmerWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 10,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(),
                color: Colors.white,
              ),
              height: 25,
              width: 25,
            )
          ],
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          height: 1,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
