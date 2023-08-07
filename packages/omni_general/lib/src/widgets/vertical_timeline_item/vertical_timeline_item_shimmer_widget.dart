import 'package:flutter/material.dart';

class VerticalTimelineItemShimmerWidget extends StatelessWidget {
  const VerticalTimelineItemShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.white),
            ),
          ),
          margin: const EdgeInsets.only(left: 10),
          padding: const EdgeInsets.only(left: 25, bottom: 15),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 0.5,
              ),
              color: Colors.white.withOpacity(0.25),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  height: 15,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      height: 15,
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      height: 15,
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0.5,
          top: 10,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
              color: Colors.white,
            ),
            width: 20,
            height: 20,
          ),
        ),
      ],
    );
  }
}
