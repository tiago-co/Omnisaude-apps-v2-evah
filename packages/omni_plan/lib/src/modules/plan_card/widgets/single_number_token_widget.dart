import 'package:flutter/material.dart';

class SingleNumberToken extends StatelessWidget {
  final String number;
  const SingleNumberToken({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
        top: 5,
        bottom: 2,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Text(
        number,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
      ),
    );
  }
}
