import 'package:flutter/material.dart';
import 'package:omni_scheduling/src/core/models/medical_records_field_model.dart';

import 'package:omni_scheduling/src/scheduling_details/pages/widgets/medical_records_subtitle_widget.dart';

class MedicalRecordsExpansionWidget extends StatefulWidget {
  final MedicalRecordsFieldModel field;
  final String? subtitle;

  const MedicalRecordsExpansionWidget({
    Key? key,
    required this.field,
    this.subtitle,
  }) : super(key: key);

  @override
  _MedicalRecordsStateExpansionWidget createState() =>
      _MedicalRecordsStateExpansionWidget();
}

class _MedicalRecordsStateExpansionWidget
    extends State<MedicalRecordsExpansionWidget>
    with SingleTickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 250);
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: duration);
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (animationController.isCompleted) {
          animationController.reverse();
        } else {
          animationController.forward();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor,
        ),
        padding: const EdgeInsets.fromLTRB(10, 0.5, 0.5, 0.5),
        margin: const EdgeInsets.only(bottom: 15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: Theme.of(context).colorScheme.background.withOpacity(0.9),
          ),
          padding: const EdgeInsets.all(10),
          child: AnimatedBuilder(
            animation: animationController,
            builder: (_, child) {
              final Animation<double> rotation =
                  Tween(begin: 0.0, end: 0.5).animate(animationController);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(child: child!),
                      RotationTransition(
                        turns: rotation,
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: animationController.isCompleted
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor,
                        ),
                      ),
                    ],
                  ),
                  FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Divider(),
                          const MedicalRecordsSubtitleWidget(
                            subtitle: 'Descrição',
                          ),
                          const SizedBox(height: 5),
                          SelectableText(
                            widget.field.description ?? 'Não informada.',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            child: ColoredBox(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.field.code != null
                        ? '${widget.field.code} - ${widget.field.name}'
                        : widget.field.name ?? 'Sem nome',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (widget.subtitle != null)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).primaryColor,
                      ),
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2.5,
                      ),
                      child: Text(
                        widget.subtitle!,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
