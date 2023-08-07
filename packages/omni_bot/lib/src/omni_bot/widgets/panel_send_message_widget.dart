import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_bot/src/core/enums/input_type_enum.dart';
import 'package:omni_bot/src/core/enums/message_type_enum.dart';
import 'package:omni_bot/src/core/enums/panel_bottom_type.dart';
import 'package:omni_bot/src/core/models/bot_message_model.dart';
import 'package:omni_bot/src/core/models/message_model.dart';
import 'package:omni_bot/src/omni_bot/omni_bot_connection.dart';
import 'package:omni_bot/src/omni_bot/stores/panel_bottom_store.dart';

import 'package:omni_bot/src/omni_bot/widgets/panel_send_message_widgets/camera_picker_widget.dart';
import 'package:omni_bot/src/omni_bot/widgets/panel_send_message_widgets/date_picker_widget.dart';
import 'package:omni_bot/src/omni_bot/widgets/panel_send_message_widgets/panel_text_field_widget.dart';
import 'package:omni_bot/src/omni_bot/widgets/panel_send_message_widgets/upload_file_widget.dart';
import 'package:omni_bot/src/omni_bot/widgets/select_widget.dart';

class PanelSendMessageWidget extends StatefulWidget {
  final BotMessageModel botMessage;
  final OmniBotConnection connection;
  const PanelSendMessageWidget({
    Key? key,
    required this.botMessage,
    required this.connection,
  }) : super(key: key);

  @override
  _PanelSendMessageWidgetState createState() => _PanelSendMessageWidgetState();
}

class _PanelSendMessageWidgetState extends State<PanelSendMessageWidget> {
  final PanelBottomStore store = Modular.get();
  final Duration duration = const Duration(milliseconds: 250);
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    store.onChangeType(widget.botMessage);
    return TripleBuilder(
      store: store,
      builder: (_, triple) {
        return AnimatedSwitcher(
          duration: duration,
          transitionBuilder: (child, animation) {
            final Animation<Offset> offset = Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.decelerate),
            );
            final Animation<double> opacity = Tween<double>(
              begin: 1,
              end: 1,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.elasticIn),
            );
            return FadeTransition(
              opacity: opacity,
              child: SlideTransition(
                position: offset,
                child: child,
              ),
            );
          },
          child: store.state == PanelBottomType.panel
              ? _buildPanelWidget
              : store.state == PanelBottomType.select
                  ? SafeArea(
                      top: false,
                      bottom: false,
                      child: SelectWidget(
                        key: const ValueKey(2),
                        select: widget.botMessage.select!,
                        connection: widget.connection,
                      ),
                    )
                  : SafeArea(
                      top: false,
                      key: const ValueKey(3),
                      child: Container(),
                    ),
        );
      },
    );
  }

  Widget get _buildPanelWidget {
    return DecoratedBox(
      key: const ValueKey(1),
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
              onSendMessage: widget.connection.onSendMessage,
              upload: widget.botMessage.upload,
              active: widget.botMessage.upload != null ||
                  store.attendanceEnabled ||
                  store.nluEnabled,
            ),
            DatePickerWidget(
              onSendMessage: widget.connection.onSendMessage,
              active: widget.botMessage.input?.inputType == InputType.date ||
                  store.attendanceEnabled ||
                  store.nluEnabled,
            ),
            Expanded(
              child: PanelTextFieldWidget(
                onSendMessage: widget.connection.onSendMessage,
                active: (widget.botMessage.input != null &&
                        widget.botMessage.input!.inputType != InputType.date) ||
                    store.attendanceEnabled ||
                    store.nluEnabled,
                input: widget.botMessage.input,
                focusNode: focusNode,
                textController: textController,
              ),
            ),
            CameraPickerWidget(
              onSendMessage: widget.connection.onSendMessage,
              active: widget.botMessage.upload != null ||
                  store.attendanceEnabled ||
                  store.nluEnabled,
            ),
            _buildSendMessageButtonWidget,
          ],
        ),
      ),
    );
  }

  Widget get _buildSendMessageButtonWidget {
    return Opacity(
      opacity: !(widget.botMessage.input != null &&
                  widget.botMessage.input!.inputType != InputType.date) ||
              store.attendanceEnabled ||
              store.nluEnabled
          ? 1.0
          : 0.25,
      child: GestureDetector(
        onTap: () {
          if (textController.text.isEmpty) return;
          final BotMessageModel message = BotMessageModel(
            message: MessageModel(
              value: textController.text,
              messageType: MessageType.text,
            ),
          );
          widget.connection.onSendMessage(message).then(
            (value) {
              textController.clear();
            },
          );
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
    );
  }
}
