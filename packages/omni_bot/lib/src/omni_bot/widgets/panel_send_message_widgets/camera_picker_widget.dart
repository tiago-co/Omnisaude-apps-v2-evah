import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_bot/omni_bot.dart';
import 'package:omni_bot/src/omni_bot/widgets/panel_send_message_widgets/add_file_comment_widget.dart';
import 'package:omni_general/omni_general.dart' show FilePickerService;

class CameraPickerWidget extends StatefulWidget {
  final Function(BotMessageModel) onSendMessage;
  final bool active;

  const CameraPickerWidget({
    Key? key,
    required this.onSendMessage,
    this.active = true,
  }) : super(key: key);

  @override
  _CameraPickerWidgetState createState() => _CameraPickerWidgetState();
}

class _CameraPickerWidgetState extends State<CameraPickerWidget> {
  final UploadFileStore store = Modular.get();
  final FilePickerService service = FilePickerService();

  Future<void> openCamera() async {
    await service.openCamera().then((file) async {
      if (file == null) return;
      await Modular.to.push(
        PageRouteBuilder(
          opaque: false,
          fullscreenDialog: true,
          barrierColor: Colors.black.withOpacity(0.5),
          transitionDuration: const Duration(milliseconds: 250),
          pageBuilder: (context, animation, secondaryAnimation) {
            animation = Tween(begin: 0.0, end: 1.0).animate(
              animation,
            );
            return FadeTransition(
              opacity: animation,
              child: AddFileCommentWidget(
                onSendMessage: widget.onSendMessage,
                image: file,
              ),
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 7.5,
        vertical: 12.5,
      ),
      child: Opacity(
        opacity: widget.active ? 1.0 : 0.25,
        child: AbsorbPointer(
          absorbing: !widget.active,
          child: GestureDetector(
            onTap: openCamera,
            child: Icon(
              Icons.camera_alt_outlined,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
      ),
    );
  }
}
