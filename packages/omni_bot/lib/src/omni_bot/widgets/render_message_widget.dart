import 'package:flutter/material.dart';
import 'package:omni_bot/src/core/enums/event_type_enum.dart';
import 'package:omni_bot/src/core/models/bot_message_model.dart';
import 'package:omni_bot/src/omni_bot/omni_bot_connection.dart';
import 'package:omni_bot/src/omni_bot/widgets/event_widget.dart';
import 'package:omni_bot/src/omni_bot/widgets/file_widget.dart';
import 'package:omni_bot/src/omni_bot/widgets/message_date_widget.dart';
import 'package:omni_bot/src/omni_bot/widgets/message_widget.dart';
import 'package:omni_bot/src/omni_bot/widgets/typing_widget.dart';

class RenderMessageWidget extends StatefulWidget {
  final BotMessageModel botMessage;
  final BotMessageModel lastBotMessage;
  final OmniBotConnection connection;
  final String? nameBot;

  const RenderMessageWidget({
    Key? key,
    required this.botMessage,
    required this.lastBotMessage,
    required this.connection,
    this.nameBot,
  }) : super(key: key);

  @override
  _RenderMessageWidgetState createState() => _RenderMessageWidgetState();
}

class _RenderMessageWidgetState extends State<RenderMessageWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget child = const SizedBox();

    // Se o objeto for um evento
    if (widget.botMessage.event != null) {
      child = EventWidget(
        key: widget.key,
        event: widget.botMessage.event!,
      );
    } else if (widget.botMessage.file != null) {
      if (widget.botMessage.peer == widget.connection.peer) {
        child = _buildUserMessage(
          widget.botMessage,
          FileWidget(
            key: widget.key,
            file: widget.botMessage.file!,
            connection: widget.connection,
          ),
        );
      } else {
        child = _buildBotMessage(
          widget.botMessage,
          FileWidget(
            key: widget.key,
            file: widget.botMessage.file!,
            connection: widget.connection,
          ),
        );
      }
    } else if (widget.botMessage.message?.value != null) {
      // Se o objeto for uma mensagem e não for mensagem vazia
      if (widget.botMessage.message!.value!.trim().isEmpty) return Container();
      if (widget.botMessage.peer == widget.connection.peer) {
        child = _buildUserMessage(
          widget.botMessage,
          MessageWidget(
            message: widget.botMessage.message!,
            connection: widget.connection,
          ),
        );
      } else {
        child = _buildBotMessage(
          widget.botMessage,
          MessageWidget(
            message: widget.botMessage.message!,
            connection: widget.connection,
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        child,
        if (widget.lastBotMessage.event?.eventType == EventType.typing)
          TypingWidget(
            isTyping:
                widget.lastBotMessage.event?.eventType != EventType.typing,
          ),
      ],
    );
  }

  Widget _buildUserMessage(BotMessageModel message, Widget child) {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.2,
        bottom: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: ColoredBox(
                color: Theme.of(context).cardColor.withOpacity(0.1),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    textTheme: TextTheme(
                      titleLarge:
                          Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.black,
                              ),
                    ),
                  ),
                  child: child,
                ),
              ),
            ),
          ),
          const SizedBox(height: 2.5),
          MessageDateWidget(
            botMessage: widget.botMessage,
            isBotMessage: widget.botMessage.peer != widget.connection.peer,
          ),
          const SizedBox(height: 2.5),
        ],
      ),
    );
  }

  Widget _buildBotMessage(BotMessageModel message, Widget child) {
    return Container(
      margin: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.2,
        bottom: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                color: Theme.of(context).primaryColor,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    textTheme: TextTheme(
                      titleLarge:
                          Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                              ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            message.name ?? widget.nameBot!,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        child,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 2.5),
          MessageDateWidget(
            botMessage: widget.botMessage,
            isBotMessage: widget.botMessage.peer != widget.connection.peer,
          ),
          const SizedBox(height: 2.5),
        ],
      ),
    );
  }
}
