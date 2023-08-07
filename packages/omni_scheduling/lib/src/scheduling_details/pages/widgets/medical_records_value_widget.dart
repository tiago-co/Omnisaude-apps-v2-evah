import 'package:flutter/material.dart';

class MedicalRecordsValueWidget extends StatelessWidget {
  final String value;
  const MedicalRecordsValueWidget({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
      ),
      padding: const EdgeInsets.fromLTRB(10, 0.5, 0.5, 0.5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: Theme.of(context).colorScheme.background.withOpacity(0.9),
        ),
        padding: const EdgeInsets.all(10),
        child: SelectableText(
          value,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
