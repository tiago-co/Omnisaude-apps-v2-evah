import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NoticeItemShimmerWidget extends StatelessWidget {
  const NoticeItemShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).primaryColor.withOpacity(0.25),
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: List.generate(
              10,
              (index) => Padding(
                padding: EdgeInsets.only(left: index == 0 ? 0 : 15),
                child: _buildNoticeItemShimmerWidget(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoticeItemShimmerWidget(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 100,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            height: 100,
          ),
          const SizedBox(height: 5),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 15,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    height: 15,
                    width: 50,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
