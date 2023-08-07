import 'package:flutter/material.dart';
import 'package:omni_mediktor/src/core/enums/mediktor_urgency_enum.dart';

class MediktorUrgencyWidget extends StatelessWidget {
  final MediktorUrgency urgency;
  const MediktorUrgencyWidget({
    Key? key,
    required this.urgency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            scrollDirection: Axis.horizontal,
            child: Text(
              urgency.label,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        const SizedBox(width: 15),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildUrgencyDotWidget(MediktorUrgency.veryLow),
              _buildUrgencyDotWidget(MediktorUrgency.low),
              _buildUrgencyDotWidget(MediktorUrgency.average),
              _buildUrgencyDotWidget(MediktorUrgency.high),
              _buildUrgencyDotWidget(MediktorUrgency.veryHigh),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUrgencyDotWidget(MediktorUrgency urgency) {
    return Tooltip(
      message: urgency.label,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: urgency == this.urgency
              ? urgency.color
              : urgency.color.withOpacity(0.1),
        ),
        height: 12.5,
        width: 12.5,
        margin: const EdgeInsets.only(left: 10),
      ),
    );
  }
}
