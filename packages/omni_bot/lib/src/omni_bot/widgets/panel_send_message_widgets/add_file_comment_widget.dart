import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mime/mime.dart';
import 'package:omni_bot/src/core/enums/file_type_enum.dart';
import 'package:omni_bot/src/core/models/bot_message_model.dart';
import 'package:omni_bot/src/core/models/file_model.dart';
import 'package:omni_bot/src/omni_bot/stores/add_file_comment_store.dart';
import 'package:omni_bot_labels/labels.dart';
import 'package:omni_general/omni_general.dart'
    show FilePickerService, PhotoViewWidget, TextFieldWidget;
import 'package:path/path.dart' show basename;

class AddFileCommentWidget extends StatefulWidget {
  final File image;
  final Function(BotMessageModel) onSendMessage;

  const AddFileCommentWidget({
    Key? key,
    required this.image,
    required this.onSendMessage,
  }) : super(key: key);

  @override
  _AddFileCommentWidgetState createState() => _AddFileCommentWidgetState();
}

class _AddFileCommentWidgetState extends State<AddFileCommentWidget> {
  final TextEditingController textEditingController = TextEditingController();
  final AddFileCommentStore store = AddFileCommentStore();

  @override
  void initState() {
    store.update(widget.image);
    super.initState();
  }

  final FilePickerService service = FilePickerService();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Future<void> onSendImage(File file) async {
    final String ext = lookupMimeType(file.path) ?? '';
    final name = basename(file.path);
    final String base64 = UriData.fromBytes(
      file.readAsBytesSync(),
      mimeType: ext,
    ).toString();
    final BotMessageModel message = BotMessageModel(
      file: FileModel(
        name: name,
        value: base64,
        file: store.state,
        fileType: FileType.image,
        comment: textEditingController.text.trim(),
      ),
    );
    widget.onSendMessage(message);
    Modular.to.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            surfaceTintColor: Theme.of(context).colorScheme.background,
            elevation: 0,
            toolbarHeight: 0,
            backgroundColor: Theme.of(context).colorScheme.background,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          body: const SizedBox(),
        ),
        Scaffold(
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Stack(
              children: [
                ClipRect(
                  child: TripleBuilder<AddFileCommentStore, Exception, File>(
                    store: store,
                    builder: (_, triple) {
                      return PhotoViewWidget(image: FileImage(triple.state));
                    },
                  ),
                ),
                _buildImageHeaderInfoWidget,
                _buildAddCommentWidget,
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget get _buildImageHeaderInfoWidget {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.2),
                Colors.transparent,
                // Colors.transparent,
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Tooltip(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.all(5),
                    message: basename(widget.image.path),
                    child: Text(
                      basename(widget.image.path),
                      overflow: TextOverflow.ellipsis,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Colors.white,
                              ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    await service.cropImage(widget.image).then((file) async {
                      if (file == null) return;
                      store.update(file);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(
                      Icons.crop,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    Modular.to.pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget get _buildAddCommentWidget {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ColoredBox(
        color: Theme.of(context).colorScheme.background.withOpacity(0.9),
        child: SafeArea(
          top: false,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      cardColor: Theme.of(context).cardColor.withOpacity(0.1),
                    ),
                    child: TextFieldWidget(
                      maxLines: 5,
                      label: BotLabels.botAddFileCommentLabel,
                      placeholder: BotLabels.botAddFileCommentPlaceholder,
                      controller: textEditingController,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await onSendImage(widget.image);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7.5,
                    vertical: 15,
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
      ),
    );
  }
}
