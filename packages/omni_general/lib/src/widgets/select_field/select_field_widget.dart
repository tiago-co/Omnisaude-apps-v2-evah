import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_general_labels/labels.dart';

class SelectFieldWidget<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final bool isLoading;
  final bool isEnabled;
  final bool showSearch;
  final bool autocorrect;
  final String? errorText;
  final String placeholder;
  final EdgeInsets? padding;
  final FocusNode? focusNode;
  final bool enableSuggestions;
  final List<String> itemsLabels;
  final ValueChanged<T> onSelectItem;
  final Function(String?)? onSearch;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final ScrollController scrollController = ScrollController();

  SelectFieldWidget({
    this.padding,
    this.onSearch,
    this.errorText,
    this.validator,
    this.focusNode,
    required this.label,
    required this.items,
    required this.itemsLabels,
    this.isLoading = false,
    this.isEnabled = true,
    this.autocorrect = true,
    this.showSearch = false,
    required this.placeholder,
    required this.controller,
    required this.onSelectItem,
    this.enableSuggestions = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLoading || !isEnabled ? 0.75 : 1.0,
      child: AbsorbPointer(
        absorbing: !isEnabled || isLoading,
        child: TextFieldWidget(
          label: label,
          placeholder: placeholder,
          controller: controller,
          readOnly: true,
          focusNode: focusNode,
          validator: validator,
          errorText: errorText,
          suffixIcon: isLoading
              ? const CircularProgressIndicator.adaptive()
              : SvgPicture.asset(
                  Assets.arrowDown,
                  color: Theme.of(context).cardColor,
                  package: AssetsPackage.omniGeneral,
                ),
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            await showModalBottomSheet(
              context: context,
              enableDrag: true,
              isScrollControlled: false,
              backgroundColor: Colors.transparent,
              builder: (_) => _buildSelectSheetWidget(_),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSelectSheetWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Theme.of(context).colorScheme.background,
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      // margin: const EdgeInsets.only(top: 60),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: BottomSheetHeaderWidget(
                title: label,
                controller: controller,
                searchPlaceholder: placeholder,
                showSearch: showSearch,
                onSearch: onSearch,
              ),
            ),
            if (isLoading)
              LinearProgressIndicator(
                minHeight: 2.5,
                color: Theme.of(context).primaryColor,
              ),
            if (!isLoading) const SizedBox(height: 2.5),
            if (items.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Center(
                  child: Text(
                    GeneralLabels.selectFieldNoneOption,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            if (items.isNotEmpty)
              Flexible(
                child: Scrollbar(
                  controller: scrollController,
                  child: ListView.separated(
                    shrinkWrap: true,
                    controller: scrollController,
                    itemCount: items.length,
                    separatorBuilder: (_, index) => const SizedBox(
                      height: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    itemBuilder: (_, index) {
                      return AbsorbPointer(
                        absorbing: isLoading,
                        child: Opacity(
                          opacity: isLoading ? 0.5 : 1.0,
                          child: SelectFieldItemWidget<T>(
                            onSelectItem: onSelectItem,
                            item: items[index],
                            label: itemsLabels[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
