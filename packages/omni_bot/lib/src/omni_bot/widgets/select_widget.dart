import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_bot/src/core/enums/layout_enum.dart';
import 'package:omni_bot/src/core/enums/render_type_enum.dart';
import 'package:omni_bot/src/core/enums/select_type_enum.dart';
import 'package:omni_bot/src/core/models/multi_selection_model.dart';
import 'package:omni_bot/src/core/models/option_model.dart';
import 'package:omni_bot/src/core/models/select_model.dart';
import 'package:omni_bot/src/core/models/selected_options_model.dart';
import 'package:omni_bot/src/omni_bot/omni_bot_connection.dart';
import 'package:omni_bot/src/omni_bot/stores/select_store.dart';
import 'package:omni_bot/src/omni_bot/widgets/select_widgets/avatar_card_widget.dart';
import 'package:omni_bot/src/omni_bot/widgets/select_widgets/button_widget.dart';
import 'package:omni_bot/src/omni_bot/widgets/select_widgets/card_widget.dart';
import 'package:omni_bot/src/omni_bot/widgets/select_widgets/image_card_widget.dart';
import 'package:omni_bot_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class SelectWidget extends StatefulWidget {
  final SelectModel select;
  final OmniBotConnection connection;
  const SelectWidget({
    Key? key,
    required this.select,
    required this.connection,
  }) : super(key: key);

  @override
  _SelectWidgetState createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget>
    with AutomaticKeepAliveClientMixin {
  final SelectStore store = Modular.get();
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    store.filteredOptions.addAll(widget.select.options!);
    store.state.max = widget.select.multiSelection?.max;
    store.state.min = widget.select.multiSelection?.min;
    store.updateState(SelectedOptionsModel.fromJson(store.state.toJson()));
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
    super.build(context);
    Widget child = const SizedBox();
    switch (widget.select.renderType) {
      case RenderType.list:
        switch (widget.select.selectType) {
          case SelectType.horizontal:
            child = SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.select.options!.map((option) {
                    return Container(
                      width: widget.select.layout != Layout.imageCard
                          ? null
                          : MediaQuery.of(context).size.width * 0.55,
                      padding: EdgeInsets.only(
                        right: widget.select.options!.last == option ? 0 : 10,
                      ),
                      child: _buildLayoutBody(option),
                    );
                  }).toList(),
                ),
              ),
            );
            break;
          case SelectType.slide:
            child = CarouselSlider.builder(
              itemCount: widget.select.options!.length,
              options: CarouselOptions(
                aspectRatio: 1.0,
                enableInfiniteScroll: false,
                viewportFraction:
                    widget.select.layout != Layout.imageCard ? 0.75 : 0.5,
                scrollPhysics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                disableCenter: true,
                height: widget.select.layout != Layout.imageCard ? 50 : null,
                enlargeCenterPage: true,
              ),
              itemBuilder: (_, index, realIndex) {
                return _buildLayoutBody(widget.select.options![index]);
              },
            );
            break;
          case SelectType.vertical:
            if (widget.select.layout == Layout.imageCard) {
              child = GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.25,
                  crossAxisCount: 2,
                ),
                shrinkWrap: true,
                itemCount: widget.select.options!.length,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemBuilder: (_, index) {
                  return _buildLayoutBody(widget.select.options![index]);
                },
              );
              break;
            }
            child = ListView.builder(
              shrinkWrap: true,
              itemCount: widget.select.options!.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemBuilder: (_, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLayoutBody(widget.select.options![index]),
                    const SizedBox(height: 10),
                  ],
                );
              },
            );
            break;
          default:
            break;
        }
        break;
      case RenderType.search:
        child = _buildSearchWidget;
        break;
      default:
        break;
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: -5,
            color: Theme.of(context).cardColor,
          ),
        ],
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(top: 10),
      child: SafeArea(
        bottom: !widget.select.multiSelection!.enabled!,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.25,
                ),
                padding: const EdgeInsets.only(bottom: 10),
                child: child,
              ),
            ),
            _btnSendMultiplesOptions(widget.select.multiSelection!),
          ],
        ),
      ),
    );
  }

  Widget _btnSendMultiplesOptions(MultiSelectionModel multiSelection) {
    if (!multiSelection.enabled!) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _minMaxOptionsWidget(multiSelection),
        ),
        const SizedBox(height: 5),
        TripleBuilder(
          store: store,
          builder: (_, triple) {
            return BottomButtonWidget(
              onPressed: () {
                store.onSendOptions(
                  store.state.selectedOptions!,
                  widget.connection,
                );
              },
              text: BotLabels.botSend,
              isDisabled: store.isDisabled(
                multiSelection.min!,
                max: multiSelection.max,
              ),
              buttonType: BottomButtonType.outline,
            );
          },
        ),
      ],
    );
  }

  Widget _minMaxOptionsWidget(MultiSelectionModel multiSelection) {
    final String label = multiSelection.min! > 1
        ? BotLabels.botMultiSelectionPlural
        : BotLabels.botMultiSelectionSingular;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        '${BotLabels.botMultiSelectionText}'
        '${multiSelection.min} $label.',
        style: const TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
      ),
    );
  }

  Widget _buildLayoutBody(OptionModel option) {
    switch (widget.select.layout) {
      case Layout.avatarCard:
        return AvatarCardWidget(
          title: option.title,
          image: option.image,
          subtitle: option.subtitle,
          onTap: () => onOptionTap(option),
        );
      case Layout.button:
        return ButtonWidget(
          title: option.title,
          onTap: () => onOptionTap(option),
        );
      case Layout.card:
        return CardWidget(
          title: option.title,
          subtitle: option.subtitle,
          onTap: () => onOptionTap(option),
        );
      case Layout.imageCard:
        return ImageCardWidget(
          title: option.title,
          image: option.image,
          subtitle: option.subtitle,
          onTap: () => onOptionTap(option),
        );
      default:
        return const SizedBox();
    }
  }

  Widget get _buildSearchWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TripleBuilder<SelectStore, Exception, SelectedOptionsModel>(
            store: store,
            builder: (_, triple) {
              if (store.filteredOptions.isEmpty) {
                return Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    BotLabels.botSelectOptionEmpty,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemCount: store.filteredOptions.length,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemBuilder: (_, index) {
                  return AbsorbPointer(
                    absorbing: triple.isLoading,
                    child: Opacity(
                      opacity: triple.isLoading ? 0.5 : 1.0,
                      child: _buildLayoutBody(store.filteredOptions[index]),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextFieldWidget(
            padding: const EdgeInsets.all(10),
            label: BotLabels.botSelectOptionLabel,
            focusNode: focusNode,
            placeholder: BotLabels.botSelectOptionPlaceholder,
            onChange: (String? input) {
              store.searchOptionByText(input!, widget.select.options!);
            },
            controller: textController,
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  VoidCallback? onOptionTap(OptionModel option) {
    if (!widget.select.multiSelection!.enabled!) {
      store.onSendOptions([option], widget.connection);
      return null;
    }

    if (store.isActive(option)) {
      store.onSelectOption(option);
    } else if (widget.select.multiSelection!.max != null) {
      if (store.state.selectedOptions!.length <
          widget.select.multiSelection!.max!) {
        store.onSelectOption(option);
      }
    }
    return null;
  }

  @override
  bool get wantKeepAlive => true;
}
