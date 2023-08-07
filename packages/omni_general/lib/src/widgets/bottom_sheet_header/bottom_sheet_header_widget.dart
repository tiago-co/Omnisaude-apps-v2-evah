import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/src/widgets/text_field/text_field_widget.dart';
import 'package:omni_general_labels/labels.dart';

class BottomSheetHeaderWidget extends StatelessWidget {
  final String title;
  final bool showSearch;
  final String? searchPlaceholder;
  final Widget? prefixIcon;
  final Function(String?)? onSearch;
  final TextEditingController? controller;

  const BottomSheetHeaderWidget({
    Key? key,
    required this.title,
    this.controller,
    this.searchPlaceholder,
    this.showSearch = false,
    this.prefixIcon,
    this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(),
                ),
              ),
              const SizedBox(width: 15),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      Text(
                        GeneralLabels.bottomSheetHeaderClose,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset(
                        Assets.close,
                        width: 10,
                        height: 10,
                        color: Colors.white,
                        package: AssetsPackage.omniGeneral,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          if (showSearch && controller != null)
            TextFieldWidget(
              enableSuggestions: false,
              label: GeneralLabels.bottomSheetHeaderSearch,
              placeholder: searchPlaceholder,
              suffixIcon: SvgPicture.asset(
                Assets.search,
                color: Theme.of(context).cardColor,
                width: 20,
                height: 20,
                package: AssetsPackage.omniGeneral,
              ),
              onChange: onSearch,
              prefixIcon: prefixIcon,
              controller: controller!,
            ),
          if (showSearch) const SizedBox(height: 10),
          if (!showSearch) const Divider(),
        ],
      ),
    );
  }
}
