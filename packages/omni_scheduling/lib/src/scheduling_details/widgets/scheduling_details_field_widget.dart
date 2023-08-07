import 'package:flutter/material.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingDetailsFieldWidget extends StatelessWidget {
  final String label;
  final String value;
  final bool showAll;

  const SchedulingDetailsFieldWidget({
    Key? key,
    required this.label,
    required this.value,
    this.showAll = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: showAll ? Axis.vertical : Axis.horizontal,
                  reverse: true,
                  physics: showAll
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                  child: SelectableText(
                    value.isNotEmpty
                        ? value
                        : SchedulingLabels.schedulingDetailsFieldEmpty,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
