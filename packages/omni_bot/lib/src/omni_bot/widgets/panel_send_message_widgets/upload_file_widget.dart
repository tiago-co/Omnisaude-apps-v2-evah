import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mime/mime.dart';
import 'package:omni_bot/src/core/enums/file_type_enum.dart';
import 'package:omni_bot/src/core/models/bot_message_model.dart';
import 'package:omni_bot/src/core/models/file_model.dart';
import 'package:omni_bot/src/core/models/upload_model.dart';
import 'package:omni_bot/src/omni_bot/stores/upload_file_store.dart';
import 'package:omni_bot/src/omni_bot/widgets/panel_send_message_widgets/add_file_comment_widget.dart';
import 'package:omni_bot_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:path/path.dart' show basename;

class UploadFileWidget extends StatefulWidget {
  final Function(BotMessageModel) onSendMessage;
  final UploadModel? upload;
  final bool active;

  const UploadFileWidget({
    Key? key,
    required this.onSendMessage,
    required this.upload,
    this.active = true,
  }) : super(key: key);

  @override
  _UploadFileWidgetState createState() => _UploadFileWidgetState();
}

class _UploadFileWidgetState extends State<UploadFileWidget> {
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
                image: file,
                onSendMessage: widget.onSendMessage,
              ),
            );
          },
        ),
      );
    });
  }

  Future<void> openGallery() async {
    await service.openGallery().then((file) async {
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
                image: file,
                onSendMessage: widget.onSendMessage,
              ),
            );
          },
        ),
      );
    });
  }

  Future<void> getFiles() async {
    await service
        .getFiles(
      allowMultiple: true,
      allowedExtensions: widget.upload?.customScope,
      withData: true,
      withReadStream: true,
    )
        .then((file) async {
      if (file.isEmpty) return;
      file.forEach((file) {
        final String ext = lookupMimeType(file.path) ?? '';
        final name = basename(file.path);
        final String base64 = UriData.fromBytes(
          file.readAsBytesSync(),
          mimeType: ext,
        ).toString();
        late final FileType fileType;
        if (ext.contains('pdf')) {
          fileType = FileType.pdf;
        } else {
          fileType = FileType.any;
        }
        final BotMessageModel message = BotMessageModel(
          file: FileModel(
            name: name,
            file: file,
            value: base64,
            fileType: widget.upload?.fileType ?? fileType,
          ),
        );
        widget.onSendMessage(message);
      });
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
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              await showModalBottomSheet(
                context: context,
                enableDrag: true,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                builder: (_) => _buildSelectSheetWidget,
              );
            },
            child: TripleBuilder(
              store: store,
              builder: (_, triple) {
                if (triple.isLoading) {
                  return const CircularProgressIndicator.adaptive();
                }
                return Icon(
                  Icons.attach_file_rounded,
                  color: Theme.of(context).cardColor,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buildSelectSheetWidget {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Theme.of(context).colorScheme.background,
      ),
      margin: const EdgeInsets.only(top: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: BottomSheetHeaderWidget(title: 'Escolha uma opção'),
          ),
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ListView.separated(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                separatorBuilder: (_, index) => const Divider(height: 0),
                itemBuilder: (_, index) {
                  switch (index) {
                    case 0:
                      return _buildSelectItemWidget(
                       BotLabels.botUploadFilePhotosVideos,
                        openGallery,
                      );
                    case 1:
                      return _buildSelectItemWidget(
                        BotLabels.botUploadFileDocuments,
                        getFiles,
                      );
                    case 2:
                      return _buildSelectItemWidget(
                        BotLabels.botUploadFileCamera,
                        openCamera,
                      );
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ),
          ),
          BottomButtonWidget(
            onPressed: () => Modular.to.pop(),
            buttonType: BottomButtonType.outline,
            text: BotLabels.botUploadFileCancel,
          ),
        ],
      ),
    );
  }

  Widget _buildSelectItemWidget(String label, Function onTap) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        enableFeedback: true,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          onTap();
          Navigator.pop(context);
        },
        minVerticalPadding: 0,
        visualDensity: VisualDensity.compact,
        title: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minLeadingWidth: 0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.arrowRight,
              color: Theme.of(context).primaryColor,
              package: AssetsPackage.omniGeneral,
              height: 15,
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
