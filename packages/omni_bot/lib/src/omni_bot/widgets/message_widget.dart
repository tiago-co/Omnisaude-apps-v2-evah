import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:omni_bot/src/core/enums/message_type_enum.dart';
import 'package:omni_bot/src/core/models/message_model.dart';
import 'package:omni_bot/src/omni_bot/omni_bot_connection.dart';
import 'package:omni_bot/src/omni_bot/stores/message_store.dart';
import 'package:omni_general/omni_general.dart';

class MessageWidget extends StatefulWidget {
  final MessageModel message;
  final OmniBotConnection connection;

  const MessageWidget({
    Key? key,
    required this.message,
    required this.connection,
  }) : super(key: key);

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget>
    with AutomaticKeepAliveClientMixin {
  final MessageStore store = MessageStore();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    switch (widget.message.messageType) {
      case MessageType.html:
        return _buildSeeMoreMessageWidget(
          _buildHtmlWidget(widget.message.value ?? ''),
        );
      case MessageType.image:
        return _buildImageWidget(widget.message);
      case MessageType.text:
        return _buildSeeMoreMessageWidget(
          _buildTextWidget(widget.message.value ?? ''),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildTextWidget(String message) {
    return Container(
      padding: const EdgeInsets.all(6.5),
      child: Text(
        message,
        overflow: TextOverflow.fade,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildHtmlWidget(String message) {
    return Html(
      data: message,
      shrinkWrap: true,
      style: {
        'body': Style(),
        'html': Style(
          fontFamily: Theme.of(context).textTheme.titleLarge!.fontFamily,
          color: Theme.of(context).textTheme.titleLarge!.color,
          // padding: const EdgeInsets.all(6.5),
        )
      },
    );
  }

  Widget _buildImageWidget(MessageModel message) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      child: ImageWidget(
        url: message.value!,
        boxFit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _buildSeeMoreMessageWidget(Widget child) {
    return Container(
      constraints: const BoxConstraints(),
      child: Stack(
        children: [
          child,
        ],
      ),
    );
  }
}
