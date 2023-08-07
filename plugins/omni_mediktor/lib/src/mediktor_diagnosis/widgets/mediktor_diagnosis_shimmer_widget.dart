import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MediktorDiagnosisShimmerWidget extends StatelessWidget {
  const MediktorDiagnosisShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(15),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).primaryColor.withOpacity(0.25),
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.25,
              height: 25,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              width: double.infinity,
              height: 25,
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
              ),
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                width: double.infinity,
                height: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
