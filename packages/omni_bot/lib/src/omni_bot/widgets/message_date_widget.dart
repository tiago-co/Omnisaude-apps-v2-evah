import 'package:flutter/material.dart';
import 'package:omni_bot/src/core/models/bot_message_model.dart';
import 'package:omni_general/omni_general.dart';

class MessageDateWidget extends StatefulWidget {
  final BotMessageModel botMessage;
  final bool isBotMessage;

  const MessageDateWidget({
    Key? key,
    required this.botMessage,
    required this.isBotMessage,
  }) : super(key: key);

  @override
  _MessageDateWidgetState createState() => _MessageDateWidgetState();
}

class _MessageDateWidgetState extends State<MessageDateWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isBotMessage ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Text(
            Formaters.dateToStringTime(
              widget.botMessage.dateTimeTimeStamp!.toDate(),
            ),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 12,
                ),
          ),
        ),
      ],
    );
  }
}
