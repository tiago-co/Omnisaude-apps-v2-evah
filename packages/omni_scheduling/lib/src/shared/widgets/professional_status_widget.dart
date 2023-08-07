import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/shared/stores/professional_status_store.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingProfessionalStatusWidget extends StatefulWidget {
  const SchedulingProfessionalStatusWidget({Key? key}) : super(key: key);

  @override
  SchedulingProfessionalStatusWidgetState createState() =>
      SchedulingProfessionalStatusWidgetState();
}

class SchedulingProfessionalStatusWidgetState
    extends State<SchedulingProfessionalStatusWidget> {
  final ProfessionalStatusStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return TripleBuilder<ProfessionalStatusStore, Exception, bool>(
      store: store,
      builder: (_, triple) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background.withOpacity(0.1),
            borderRadius: BorderRadius.circular(7.5),
            border: Border.all(
              color: triple.state ? Colors.green : Colors.red,
              width: 0.5,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: triple.state ? Colors.green : Colors.red,
                ),
                padding: const EdgeInsets.all(2.5),
              ),
              const SizedBox(width: 5),
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    triple.state ? SchedulingLabels.professionalStatusOnline : SchedulingLabels.professionalStatusOffline,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: triple.state ? Colors.green : Colors.red,
                        ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
