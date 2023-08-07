import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/src/app/core/models/dynamic_option_model.dart';
import 'package:omni_core/src/app/core/models/select_field_model.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/widgets/dynamic_field_info_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:shared_labels/labels.dart';

class DynamicSelectWidget extends StatefulWidget {
  final bool readOnly;
  final SelectFieldModel select;
  final Function(String?)? onChangeAnswer;

  const DynamicSelectWidget({
    Key? key,
    required this.select,
    this.readOnly = false,
    this.onChangeAnswer,
  })  : assert(readOnly ? onChangeAnswer == null : !readOnly),
        super(key: key);

  @override
  _DynamicSelectWidgetState createState() => _DynamicSelectWidgetState();
}

class _DynamicSelectWidgetState extends State<DynamicSelectWidget> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    if (widget.readOnly) {
      textEditingController.text = widget.select.answer ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.readOnly) {
      return TextFieldWidget(
        controller: textEditingController,
        label: widget.select.name ?? SharedLabels.dynamicSelectNoName,
        placeholder: widget.select.placeholder ??
            SharedLabels.dynamicSelectNoDescription,
        readOnly: true,
        suffixIcon: GestureDetector(
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
              builder: (_) => DynamicFieldInfoWidget(
                name: widget.select.name ?? SharedLabels.dynamicSelectNoName,
                placeholder: widget.select.placeholder ??
                    SharedLabels.dynamicSelectNoDescription,
              ),
            );
          },
          child: ColoredBox(
            color: Theme.of(context).colorScheme.background,
            child: SvgPicture.asset(
              Assets.info,
              package: AssetsPackage.omniGeneral,
              color: Theme.of(context).primaryColor,
              width: 25,
              height: 25,
            ),
          ),
        ),
      );
    }
    return SelectFieldWidget<DynamicOptionModel>(
      label: widget.select.name ?? SharedLabels.dynamicSelectNoName,
      items: widget.select.options!,
      itemsLabels:
          widget.select.options!.map((option) => option.title!).toList(),
      placeholder:
          widget.select.placeholder ?? SharedLabels.dynamicSelectNoDescription,
      controller: textEditingController,
      onSelectItem: (DynamicOptionModel value) {
        textEditingController.text = value.title!;
        widget.onChangeAnswer!(value.title);
      },
      validator: !widget.select.isRequired!
          ? null
          : (String? input) {
              if (input == null) {
                return null;
              } else if (input.isEmpty) {
                return SharedLabels.dynamicSelectEmpty;
              }
              return null;
            },
    );
  }
}
