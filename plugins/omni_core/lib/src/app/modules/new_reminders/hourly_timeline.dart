import 'package:flutter/material.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/reminders/reminder_item.dart';

class Event {
  final int id;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String description;

  Event({required this.id, required this.startTime, required this.endTime, required this.description});
}

class HourlyTimeline extends StatefulWidget {
  final int hour;
  final List<Event> events;
  ValueNotifier<int> lastId;

  HourlyTimeline({required this.hour, required this.events, required this.lastId});

  @override
  State<HourlyTimeline> createState() => _HourlyTimelineState();
}

class _HourlyTimelineState extends State<HourlyTimeline> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 75, // altura para 1 hora
          child: Row(
            children: [
              Container(
                width: 50,
                child: Text('${widget.hour.toString().padLeft(2, '0')}:00'),
              ),
              Expanded(
                child: Container(
                  child: Divider(height: 5, thickness: 2, color: Colors.grey.shade200),
                ),
              ),
            ],
          ),
        ),
        ..._buildEventsForThisHour(),
      ],
    );
  }

  List<Widget> _buildEventsForThisHour() {
    final event = widget.events.firstWhere((e) {
      if ((e.startTime.hour <= widget.hour && e.endTime.hour >= widget.hour) && widget.lastId != e.id) {
        return true;
      } else {
        // lastId = 0;
        return false;
      }
    });
    widget.lastId.value = widget.lastId.value == event.id ? 0 : event.id;

    bool buildFullWidget = true;
    // Cálculo da posição vertical baseado na hora de início do evento
    // double topOffset = (event.startTime.hour == hour) ? event.startTime.minute / 60 * 60 :  0;
    double topOffset =
        (event.startTime.hour == widget.hour) ? event.startTime.minute / 60 * 90 : (60 / event.startTime.minute);

    // Cálculo da altura baseado na duração do evento
    double height =
        ((event.endTime.hour + (event.endTime.minute / 60)) - event.startTime.hour + (event.startTime.minute / 60)) *
            90;
    // lastId = event.startTime.hour == hour ? event.id : lastId;
    // if (event.startTime.hour == hour) {
    //   height = ((event.endTime.hour - event.startTime.hour) * 60 + (event.endTime.minute - event.startTime.minute))
    //       .toDouble();
    //   lastId = event.id;
    // } else if (event.endTime.hour == hour) {
    //   height = event.endTime.minute / 60 * 60;
    //   buildFullWidget = false;
    // } else {
    //   height = 75; // Preenche toda a hora
    // }
    List<Widget> lista = [];
    // lista.add(widget.lastId.value == event.id
    //     ? Positioned(
    //         top: topOffset,
    //         left: 55, // Logo após o divider
    //         right: 0,
    //         height: 70,
    //         child: ReminderItem(buildFullWidget: buildFullWidget),
    //       )
    //     : Container(
    //         color: Colors.transparent,
    //       ));
    return lista;
  }
}
