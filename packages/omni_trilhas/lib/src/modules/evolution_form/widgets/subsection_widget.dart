import 'package:flutter/material.dart';
import 'package:omni_trilhas/src/modules/evolution_form/widgets/generic_details_widget.dart';
import 'package:omni_trilhas/src/modules/evolution_form/widgets/subtitle_widget.dart';

class SubsectionWidget extends StatelessWidget {
  final String subtitle;
  final Map<String, dynamic> data;
  const SubsectionWidget({
    Key? key,
    required this.subtitle,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SubtitleWidget(subtitle: subtitle),
        ),
        GenericDetailsWidget(
          modelData: data,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
