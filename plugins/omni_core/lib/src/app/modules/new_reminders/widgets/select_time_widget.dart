import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/new_drug_control_store.dart';
import 'package:omni_general/omni_general.dart';

class SelectTimeWidget extends StatefulWidget {
  SelectTimeWidget({required this.controller, Key? key}) : super(key: key);
  final TextEditingController controller;

  @override
  State<SelectTimeWidget> createState() => _SelectTimeWidgetState();
}

class _SelectTimeWidgetState extends State<SelectTimeWidget> {
  final NewDrugControlStore store = Modular.get();

  final List<String> items = [
    '00:00',
    '18:00',
    '18:15',
    '18:30',
    '18:45',
    '19:00',
    '19:15',
    '19:30',
  ];

  List<String> generateTimeSlots() {
    List<String> times = [];
    for (int i = 0; i < 24; i++) {
      for (int j = 0; j < 60; j += 15) {
        times.add('${i.toString().padLeft(2, '0')}:${j.toString().padLeft(2, '0')}');
      }
    }
    return times;
  }

  getTime(String value) {
    final list = value.split(':');
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 24,
        right: 12,
        top: 4,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffededf1),
        ),
        borderRadius: BorderRadius.circular(60),
      ),
      child: DropdownButton<String>(
        value: widget.controller.text.isEmpty ? '00:00' : widget.controller.text,
        menuMaxHeight: 350,
        hint: const Text('00:00'),
        icon: const SizedBox(),
        items: generateTimeSlots().map((time) {
          return DropdownMenuItem<String>(
            value: time,
            child: Text(time),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() {
              widget.controller.text = value;
              final datetime = Formaters.stringToDateTime(store.state.startDate!).add(
                Duration(
                  hours: int.parse(getTime(value)[0]),
                  minutes: int.parse(getTime(value)[1]),
                ),
              );
              store.state.startHour = datetime.toIso8601String();
              ;
              store.state.startDate = Formaters.dateToStringDateTime(
                datetime,
              );

              // store.state.startHour = widget.controller.text;
            });
          }
        },
        underline: const SizedBox(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
    // TextFieldWidget(
    //   label: 'Hora de Início',
    //   controller: TextEditingController(),
    //   focusedborder: InputBorder.none,
    //   onTap: () {},
    // );
  }
}
