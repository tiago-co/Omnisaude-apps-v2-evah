import 'package:flutter/material.dart';
import 'package:omni_bot/src/core/enums/message_type_enum.dart';
import 'package:omni_bot/src/core/models/bot_message_model.dart';
import 'package:omni_bot/src/core/models/message_model.dart';
import 'package:omni_general/omni_general.dart';

class DatePickerWidget extends StatelessWidget {
  final Function(BotMessageModel) onSendMessage;
  final bool active;

  const DatePickerWidget({
    Key? key,
    required this.onSendMessage,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 7.5,
        vertical: 12.5,
      ),
      child: Opacity(
        opacity: active ? 1.0 : 0.25,
        child: AbsorbPointer(
          absorbing: !active,
          child: GestureDetector(
            onTap: () {
              final DateTimePickerService service = DateTimePickerService();
              service
                  .selectDate(
                context,
                minDate: DateTime(1920),
                enablePastDates: true,
              )
                  .then((dateTime) {
                if (dateTime == null) return;
                final BotMessageModel message = BotMessageModel(
                  message: MessageModel(
                    value: Formaters.dateToStringDate(dateTime),
                    messageType: MessageType.text,
                  ),
                );
                onSendMessage(message);
              });
            },
            child: Icon(
              Icons.date_range_outlined,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
      ),
    );
  }
}
