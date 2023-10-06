import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 1),
            height: 1,
            color: const Color(0xffededf1),
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        const Text(
          'ou',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.6000000238,
            color: Color(0xff1a1c22),
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 1),
            height: 1,
            color: const Color(0xffededf1),
          ),
        ),
      ],
    );
  }
}
