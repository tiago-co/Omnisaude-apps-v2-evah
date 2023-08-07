import 'package:flutter/material.dart';

class SubtitleWidget extends StatelessWidget {
  final String subtitle;

  const SubtitleWidget({Key? key, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
