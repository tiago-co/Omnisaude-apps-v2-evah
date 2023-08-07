import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DetailsItemExtractShimmer extends StatelessWidget {
  const DetailsItemExtractShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ColoredBox(
        color: Theme.of(context).colorScheme.background,
        child: Shimmer.fromColors(
          baseColor: Theme.of(context).primaryColor.withOpacity(0.25),
          highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  children: List.generate(
                    10,
                    (index) => Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 21,
                        horizontal: 10,
                      ),
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
                                width: MediaQuery.of(context).size.width * 0.70,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
