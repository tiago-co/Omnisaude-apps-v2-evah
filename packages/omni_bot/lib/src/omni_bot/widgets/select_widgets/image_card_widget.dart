import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_bot/src/omni_bot/stores/select_store.dart';
import 'package:omni_bot/src/omni_bot/stores/select_widget_state_store.dart';
import 'package:omni_bot/src/omni_bot/widgets/select_widgets/option_info_widget.dart';
import 'package:omni_bot_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';

class ImageCardWidget extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final String? image;
  final VoidCallback onTap;
  const ImageCardWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  _ImageCardWidgetState createState() => _ImageCardWidgetState();
}

class _ImageCardWidgetState extends State<ImageCardWidget>
    with AutomaticKeepAliveClientMixin {
  final SelectStore selectStore = Modular.get();
  final SelectWidgetStateStore widgetStateStore = Modular.get();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ScopedBuilder<SelectWidgetStateStore, Exception, bool>(
      store: widgetStateStore,
      onState: (_, triple) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onButtonTap,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: widgetStateStore.state
                          ? Theme.of(context).primaryColor
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ColoredBox(
                            color: Theme.of(context).cardColor.withOpacity(0.1),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AbsorbPointer(
                                  child: ImageWidget(
                                    url: widget.image ?? '',
                                    asset: Assets.test,
                                    boxFit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: _buildOptionInfoWidget(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                        _buildTextDescription(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildOptionInfoWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Helpers.showDialog(
          context,
          OptionInfoWidget(
            isSelected: widgetStateStore.state,
            title: widget.title,
            subtitle: widget.subtitle,
            image: widget.image,
            onPressed: onButtonTap,
          ),
          showClose: true,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: widgetStateStore.state
              ? Theme.of(context).primaryColor.withOpacity(0.25)
              : Theme.of(context).colorScheme.background.withOpacity(0.25),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        child: SvgPicture.asset(
          Assets.info,
          package: AssetsPackage.omniGeneral,
          color: widgetStateStore.state
              ? Colors.white
              : Theme.of(context).primaryColor,
          width: 20,
          height: 20,
        ),
      ),
    );
  }

  Widget _buildTextDescription(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.title ?? BotLabels.botCardEmptyTitle,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontStyle: widget.title == null ? FontStyle.italic : null,
                  color: widgetStateStore.state ? Colors.white : null,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.subtitle ?? BotLabels.botCardEmptySubTitle,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontStyle: widget.subtitle == null ? FontStyle.italic : null,
                  color: widgetStateStore.state ? Colors.white : null,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  VoidCallback? onButtonTap() {
    if (!selectStore.reachedMaxOptions()) {
      widget.onTap();
      widgetStateStore.updateState(!widgetStateStore.state);
    } else if (widgetStateStore.state) {
      widget.onTap();
      widgetStateStore.updateState(!widgetStateStore.state);
    } else {
      selectStore.showMaxSelectionReachedSnackBar(context);
    }
    return null;
  }

  @override
  bool get wantKeepAlive => true;
}
