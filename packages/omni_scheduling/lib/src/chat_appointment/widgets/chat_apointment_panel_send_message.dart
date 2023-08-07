import 'package:flutter/material.dart';
import 'package:omni_bot/omni_bot.dart';

class ChatAppointmentPanelSendMessage extends StatefulWidget {
  final Function(BotMessageModel) onSendMessage;
  final Function(BotMessageModel) onSendFile;
  final BotMessageModel botMessageModel;

  const ChatAppointmentPanelSendMessage({
    Key? key,
    required this.onSendFile,
    required this.onSendMessage,
    required this.botMessageModel,
  }) : super(key: key);

  @override
  _ChatAppointmentPanelSendMessageState createState() =>
      _ChatAppointmentPanelSendMessageState();
}

class _ChatAppointmentPanelSendMessageState
    extends State<ChatAppointmentPanelSendMessage> {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: -5,
            color: Theme.of(context).cardColor,
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            UploadFileWidget(
              onSendMessage: widget.onSendFile,
              upload: widget.botMessageModel.upload,
            ),
            Expanded(
              child: PanelTextFieldWidget(
                focusNode: focusNode,
                textController: textController,
                onSendMessage: widget.onSendMessage,
              ),
            ),
            CameraPickerWidget(onSendMessage: widget.onSendFile),
            GestureDetector(
              onTap: () {
                if (textController.text.isEmpty) return;
                final BotMessageModel message = BotMessageModel(
                  message: MessageModel(
                    value: textController.text,
                    messageType: MessageType.text,
                  ),
                );
                widget.onSendMessage(message).then((value) {
                  textController.clear();
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7.5,
                  vertical: 12.5,
                ),
                child: Icon(
                  Icons.send_rounded,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
