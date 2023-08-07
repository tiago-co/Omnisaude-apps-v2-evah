import 'package:flutter/material.dart';
import 'package:omni_mediktor/src/core/models/session_conclusion_object_model.dart';

class MediktorDetailsCardWidget extends StatelessWidget {
  final SessionConclusionObject diagnosis;
  const MediktorDetailsCardWidget({
    Key? key,
    required this.diagnosis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            diagnosis.description!,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            diagnosis.specialties
                .toString()
                .replaceAll('[', '')
                .replaceAll(']', ''),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Theme.of(context).cardColor.withOpacity(0.4),
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: diagnosis.percentage! / 100,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF02D117),
              ),
              backgroundColor: Theme.of(context).cardColor.withOpacity(0.25),
            ),
          ),
        ],
      ),
    );
  }
}
