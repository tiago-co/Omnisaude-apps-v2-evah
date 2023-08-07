import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/src/app/core/enums/dynamic_form_field_enum.dart';
import 'package:omni_core/src/app/core/models/input_field_model.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/shared/widgets/dynamic_form/widgets/dynamic_field_info_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:shared_labels/labels.dart';

class DynamicInputWidget extends StatefulWidget {
  final InputFieldModel input;
  final bool readOnly;
  final Function(String?)? onChangeAnswer;

  const DynamicInputWidget({
    Key? key,
    required this.input,
    this.readOnly = false,
    this.onChangeAnswer,
  })  : assert(readOnly ? onChangeAnswer == null : !readOnly),
        super(key: key);

  @override
  _DynamicInputWidgetState createState() => _DynamicInputWidgetState();
}

class _DynamicInputWidgetState extends State<DynamicInputWidget> {
  final TextEditingController textEditingController = TextEditingController();
  final DateTimePickerService service = DateTimePickerService();

  @override
  void initState() {
    if (widget.readOnly) {
      textEditingController.text = widget.input.answer ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.readOnly) {
      return TextFieldWidget(
        controller: textEditingController,
        label: widget.input.name ?? SharedLabels.dynamicInputNoName,
        placeholder:
            widget.input.placeholder ?? SharedLabels.dynamicInputNoDescription,
        readOnly: true,
        suffixIcon: _buildFieldInfoWidget,
      );
    }

    TextInputType? keyboardType;
    TextCapitalization? textCapitalization;
    switch (widget.input.inputType) {
      case InputType.date:
        return TextFieldWidget(
          controller: textEditingController,
          label: widget.input.name ?? SharedLabels.dynamicInputNoName,
          placeholder: widget.input.placeholder ??
              SharedLabels.dynamicInputNoDescription,
          readOnly: true,
          onChange: widget.onChangeAnswer,
          suffixIcon: _buildFieldInfoWidget,
          onTap: () async {
            late final DateTime initialDisplayDate;
            try {
              initialDisplayDate = Formaters.stringToDate(
                textEditingController.text,
                format: 'dd/MM/yyyy',
              );
            } on FormatException {
              initialDisplayDate = DateTime.now();
            }
            await service
                .selectDate(
              context,
              initialDisplayDate: initialDisplayDate,
              enablePastDates: true,
            )
                .then((dateTime) {
              FocusScope.of(context).requestFocus(FocusNode());
              if (dateTime == null) return;
              textEditingController.text = Formaters.dateToStringDate(
                dateTime,
              );
              widget.onChangeAnswer!(textEditingController.text);
            });
          },
          validator: !widget.input.isRequired!
              ? null
              : (String? input) {
                  if (input == null) {
                    return null;
                  } else if (input.isEmpty) {
                    return SharedLabels.dynamicInputEmpty;
                  }
                  return null;
                },
        );
      case InputType.decimal:
        keyboardType ??= const TextInputType.numberWithOptions(decimal: true);
        break;
      case InputType.integer:
        keyboardType = TextInputType.number;
        break;
      default:
        break;
    }

    switch (widget.input.keyboardType) {
      case KeyboardType.email:
        keyboardType ??= TextInputType.emailAddress;
        textCapitalization = TextCapitalization.none;
        break;
      case KeyboardType.number:
        keyboardType ??= const TextInputType.numberWithOptions(decimal: true);
        break;
      case KeyboardType.text:
        keyboardType ??= TextInputType.text;
        textCapitalization = TextCapitalization.sentences;
        break;
      default:
        keyboardType ??= TextInputType.text;
        textCapitalization = TextCapitalization.sentences;
    }

    return TextFieldWidget(
      label: widget.input.name ?? SharedLabels.dynamicInputNoName,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      placeholder:
          widget.input.placeholder ?? SharedLabels.dynamicInputNoDescription,
      controller: textEditingController,
      suffixIcon: _buildFieldInfoWidget,
      onChange: widget.onChangeAnswer,
      mask: widget.input.mask != null
          ? Masks.generateMask(widget.input.mask!)
          : null,
      validator: !widget.input.isRequired!
          ? null
          : (String? input) {
              if (input == null) {
                return null;
              } else if (input.isEmpty) {
                return SharedLabels.dynamicInputEmpty;
              }
              return null;
            },
    );
  }

  Widget get _buildFieldInfoWidget {
    return GestureDetector(
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
            name: widget.input.name ?? SharedLabels.dynamicInputNoName,
            placeholder: widget.input.placeholder ??
                SharedLabels.dynamicInputNoDescription,
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
    );
  }
}
