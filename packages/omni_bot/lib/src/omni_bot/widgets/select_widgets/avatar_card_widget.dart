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

class AvatarCardWidget extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final String? image;
  final VoidCallback onTap;
  const AvatarCardWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  _AvatarCardWidgetState createState() => _AvatarCardWidgetState();
}

class _AvatarCardWidgetState extends State<AvatarCardWidget>
    with AutomaticKeepAliveClientMixin {
  final SelectStore selectStore = Modular.get();
  final SelectWidgetStateStore widgetStateStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ScopedBuilder<SelectWidgetStateStore, Exception, bool>(
      store: widgetStateStore,
      onState: (_, triple) {
        return GestureDetector(
          onTap: onButtonTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: widgetStateStore.state
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(right: 7.5),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ColoredBox(
                    color: Theme.of(context).cardColor.withOpacity(0.1),
                    child: AbsorbPointer(
                      child: ImageWidget(
                        url: widget.image ?? '',
                        asset: Assets.test,
                        boxFit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: _buildTextDescription(context),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Helpers.showDialog(
                        context,
                        OptionInfoWidget(
                          title: widget.title,
                          subtitle: widget.subtitle,
                          onPressed: onButtonTap,
                        ),
                      );
                    },
                    child: ColoredBox(
                      color: Colors.transparent,
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextDescription(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Text(
            widget.title ?? BotLabels.botCardEmptyTitle,
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
