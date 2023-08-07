import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ExamsItemShimmerWidget extends StatelessWidget {
  const ExamsItemShimmerWidget({Key? key}) : super(key: key);

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
              (index) => Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 21, horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 0.5,
                  ),
                  color: Colors.white.withOpacity(0.25),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          height: 25,
                          width: MediaQuery.of(context).size.width * 0.065,
                        ),
                        const SizedBox(width: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          height: 25,
                          width: MediaQuery.of(context).size.width * 0.70,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
