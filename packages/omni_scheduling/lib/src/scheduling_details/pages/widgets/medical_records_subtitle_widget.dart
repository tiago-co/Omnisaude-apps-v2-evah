import 'package:flutter/material.dart';

class MedicalRecordsSubtitleWidget extends StatelessWidget {
  final String subtitle;
  const MedicalRecordsSubtitleWidget({
    Key? key,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}
