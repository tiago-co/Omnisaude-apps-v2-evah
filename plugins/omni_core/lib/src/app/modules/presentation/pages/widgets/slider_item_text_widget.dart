import 'package:flutter/material.dart';

class SliderItemTextWidget extends StatelessWidget {
  final String text;

  const SliderItemTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}
