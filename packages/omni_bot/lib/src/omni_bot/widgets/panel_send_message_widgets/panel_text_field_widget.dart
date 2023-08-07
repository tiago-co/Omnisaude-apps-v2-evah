import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omni_bot/src/core/enums/keyboard_type_enum.dart';
import 'package:omni_bot/src/core/enums/message_type_enum.dart';
import 'package:omni_bot/src/core/models/bot_message_model.dart';
import 'package:omni_bot/src/core/models/input_model.dart';
import 'package:omni_bot/src/core/models/message_model.dart';
import 'package:omni_bot_labels/labels.dart';
import 'package:omni_general/omni_general.dart' show Masks;

class PanelTextFieldWidget extends StatelessWidget {
  final Function(BotMessageModel) onSendMessage;
  final TextEditingController textController;
  final FocusNode focusNode;
  final InputModel? input;
  final bool active;

  const PanelTextFieldWidget({
    Key? key,
    this.input,
    this.active = true,
    required this.focusNode,
    required this.onSendMessage,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final TextCapitalization textCapitalization;
    late final TextInputType keyboardType;

    switch (input?.keyboardType) {
      case KeyboardType.email:
        keyboardType = TextInputType.emailAddress;
        textCapitalization = TextCapitalization.none;
        break;
      case KeyboardType.number:
        keyboardType = const TextInputType.numberWithOptions(decimal: true);
        textCapitalization = TextCapitalization.sentences;
        break;
      default:
        textCapitalization = TextCapitalization.sentences;
        keyboardType = TextInputType.text;
        break;
    }
    return Opacity(
      opacity: active ? 1.0 : 0.25,
      child: AbsorbPointer(
        absorbing: !active,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: CupertinoTextField(
            minLines: 1,
            maxLines: 5,
            keyboardType: keyboardType,
            controller: textController,
            focusNode: focusNode,
            placeholder: BotLabels.botPanelTextPlaceholder,
            placeholderStyle: Theme.of(context).textTheme.titleLarge,
            autofocus: true,
            textInputAction: TextInputAction.send,
            textCapitalization: textCapitalization,
            textAlignVertical: TextAlignVertical.center,
            padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 10),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                ),
            inputFormatters: input?.mask != null
                ? [
                    Masks.generateMask(input!.mask!),
                  ]
                : null,
            onEditingComplete: () {
              if (textController.text.isEmpty) return;
              final BotMessageModel message = BotMessageModel(
                message: MessageModel(
                  value: textController.text.trim(),
                  messageType: MessageType.text,
                ),
              );
              onSendMessage(message);
              textController.clear();
            },
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
