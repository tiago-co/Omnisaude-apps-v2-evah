import 'dart:math';

import 'package:flutter/material.dart';
import 'package:omni_general/omni_general.dart';
import 'package:shimmer/shimmer.dart';

class InformativeDetailsShimmerWidget extends StatelessWidget {
  const InformativeDetailsShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).primaryColor.withOpacity(0.25),
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.all(15),
                child: ListView.separated(
                  itemCount: 50,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(height: 15),
                  itemBuilder: (_, index) {
                    return _buildInformativeDetailsWidget(context);
                  },
                ),
              ),
            ),
            BottomButtonWidget(
              onPressed: () {},
              text: 'text',
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInformativeDetailsWidget(BuildContext context) {
    final int widthRadio = Random().nextInt(5);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: 15,
          width: MediaQuery.of(context).size.width *
              (widthRadio > 0 ? 1 / widthRadio : 0.7),
        ),
      ],
    );
  }
}
