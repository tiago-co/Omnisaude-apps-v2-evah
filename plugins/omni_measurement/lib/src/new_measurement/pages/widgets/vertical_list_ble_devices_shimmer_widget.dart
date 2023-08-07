import 'package:flutter/material.dart';

class VerticalListBleDevicesShimmerWidget extends StatelessWidget {
  const VerticalListBleDevicesShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 15),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.white,
                    ),
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.10,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      height: 15,
                      width: MediaQuery.of(context).size.width * 0.15,
                    ),
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
                  ],
                ),
              ],
            ),
          ),
        ),
        // Positioned(
        //   left: 0.5,
        //   top: 10,
        //   child: Container(
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       border: Border.all(color: Colors.white),
        //       color: Colors.white,
        //     ),
        //     width: 20,
        //     height: 20,
        //   ),
        // ),
      ],
    );
  }
}
