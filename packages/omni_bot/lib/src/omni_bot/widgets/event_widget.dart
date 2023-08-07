import 'package:flutter/material.dart';
import 'package:omni_bot/src/core/enums/event_type_enum.dart';
import 'package:omni_bot/src/core/models/event_model.dart';

class EventWidget extends StatelessWidget {
  final EventModel event;
  const EventWidget({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (event.eventType == EventType.typing) return Container();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
            child: Text(
              event.eventType!.label!,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 12,
                  ),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}
