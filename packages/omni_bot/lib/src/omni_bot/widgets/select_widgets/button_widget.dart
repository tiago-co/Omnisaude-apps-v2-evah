import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_bot/src/omni_bot/stores/select_store.dart';
import 'package:omni_bot/src/omni_bot/stores/select_widget_state_store.dart';
import 'package:omni_bot/src/omni_bot/widgets/select_widgets/option_info_widget.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';

class ButtonWidget extends StatefulWidget {
  final String? title;
  final VoidCallback onTap;

  const ButtonWidget({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget>
    with AutomaticKeepAliveClientMixin {
  final SelectStore selectStore = Modular.get();
  final SelectWidgetStateStore widgetStateStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return TripleBuilder<SelectWidgetStateStore, Exception, bool>(
      store: widgetStateStore,
      builder: (_, triple) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onButtonTap,
              child: Container(
                decoration: BoxDecoration(
                  color: widgetStateStore.state
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).cardColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 7.5,
                  vertical: 15,
                ),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title!,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                            height: 1,
                            fontStyle:
                                widget.title == null ? FontStyle.italic : null,
                            color: widgetStateStore.state ? Colors.white : null,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Helpers.showDialog(
                          context,
                          OptionInfoWidget(
                            title: widget.title,
                            onPressed: onButtonTap,
                            isSelected: widgetStateStore.state,
                          ),
                          showClose: true,
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
          ],
        );
      },
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
