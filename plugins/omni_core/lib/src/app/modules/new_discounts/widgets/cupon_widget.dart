import 'package:flutter/material.dart';

class CuponWidget extends StatelessWidget {
  const CuponWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffededf1)),
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0f1f2023),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            // rectangle36mQ3 (I4902:29248;4902:25943)
            margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const FlutterLogo(),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // drograriasopauloPgK (I4902:29248;2631:17573)

                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: const Text(
                    'Droga Raia',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.6000000238,
                      color: Color(0xff1a1c22),
                    ),
                  ),
                ),
                SizedBox(
                  // width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // statusgfR (I4902:29248;4902:25317)
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xfff1f8fd),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Center(
                          child: Text(
                            'Até 30% off',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.4000000272,
                              color: Color(0xff2d72b3),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // statusxsq (I4902:29248;4902:23631)

                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xfff6f6f8),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Center(
                          child: Text(
                            'Offline',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.4000000272,
                              color: Color(0xff878da0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
