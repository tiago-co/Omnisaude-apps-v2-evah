import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_bot/omni_bot.dart';
import 'package:omni_bot/src/omni_bot/widgets/message_widget.dart';
import 'package:omni_bot_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class FileWidget extends StatefulWidget {
  final FileModel file;
  final OmniBotConnection connection;
  const FileWidget({
    Key? key,
    required this.file,
    required this.connection,
  }) : super(key: key);

  @override
  _FileWidgetState createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget>
    with AutomaticKeepAliveClientMixin {
  final PdfViewService service = PdfViewService();
  final UploadFileStore store = UploadFileStore();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    switch (widget.file.fileType) {
      case FileType.pdf:
        break;
      default:
        break;
    }
    super.initState();
  }

  @override
  void dispose() {
    store.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Builder(
      key: widget.key,
      builder: (_) {
        switch (widget.file.fileType) {
          case FileType.custom:
            return _buildGenericFileWidget;
          case FileType.image:
            return _buildImageFileWidget;
          case FileType.pdf:
            store.loadPDFPreview(service, widget.file.value ?? '');
            return _buildPdfFileWidget;
          case FileType.any:
            return _buildGenericFileWidget;
          default:
            return const SizedBox();
        }
      },
    );
  }

  Widget get _buildImageFileWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.5),
          ),
          padding: const EdgeInsets.all(2.5),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(9),
              topLeft: const Radius.circular(9),
              bottomLeft: Radius.circular(
                widget.file.comment != null && widget.file.comment!.isNotEmpty
                    ? 0
                    : 9,
              ),
            ),
            child: MessageWidget(
              message: MessageModel(
                messageType: MessageType.image,
                value: widget.file.value,
              ),
              connection: widget.connection,
            ),
          ),
        ),
        if (widget.file.comment != null && widget.file.comment!.isNotEmpty)
          MessageWidget(
            message: MessageModel(
              messageType: MessageType.text,
              value: widget.file.comment,
            ),
            connection: widget.connection,
          ),
      ],
    );
  }

  Widget get _buildPdfFileWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.5),
          ),
          padding: const EdgeInsets.all(2.5),
          height: 100,
          child: TripleBuilder(
            store: store,
            builder: (_, triple) {
              if (triple.isLoading) {
                return const CircularProgressIndicator.adaptive();
              }
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(9),
                  topLeft: Radius.circular(9),
                ),
                child: AbsorbPointer(child: service.pdfSinglePageView(context)),
              );
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.25),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.file.name ?? BotLabels.botFileNamePlaceholder,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.25),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    Icons.share_rounded,
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (widget.file.comment != null && widget.file.comment!.isNotEmpty)
          MessageWidget(
            message: MessageModel(
              messageType: MessageType.text,
              value: widget.file.comment,
            ),
            connection: widget.connection,
          ),
      ],
    );
  }

  Widget get _buildGenericFileWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.25),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.file.name ?? BotLabels.botFileNamePlaceholder,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context)
                      .colorScheme
                      .background
                      .withOpacity(0.25),
                ),
                padding: const EdgeInsets.all(5),
                child: Icon(
                  Icons.share_rounded,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            ],
          ),
        ),
        if (widget.file.comment != null && widget.file.comment!.isNotEmpty)
          MessageWidget(
            message: MessageModel(
              messageType: MessageType.text,
              value: widget.file.comment,
            ),
            connection: widget.connection,
          ),
      ],
    );
  }
}
