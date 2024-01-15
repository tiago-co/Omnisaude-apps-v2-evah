import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final bool autocorrect;
  final bool readOnly;
  final bool isEnabled;
  final FocusNode? focusNode;
  final String? placeholder;
  final String? errorText;
  final EdgeInsets? padding;
  final bool enableSuggestions;
  final bool obscureText;
  final Function(String?)? onChange;
  final Function()? onTap;
  final TextEditingController controller;
  final int? maxLines;
  final int minLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;
  final MaskTextInputFormatter? mask;
  final TextAlign textAlign;
  final int? maxLenght;
  final InputBorder? focusedborder;
  final TextStyle? textStyle;
  final double fem;

  const TextFieldWidget({
    Key? key,
    required this.label,
    this.placeholder,
    this.errorText,
    this.mask,
    this.focusNode,
    this.onSubmitted,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.sentences,
    this.enableSuggestions = true,
    this.autocorrect = false,
    this.readOnly = false,
    this.isEnabled = true,
    required this.controller,
    this.onChange,
    this.onTap,
    this.padding,
    this.maxLines,
    this.prefixIcon,
    this.validator,
    this.suffixIcon,
    this.minLines = 1,
    this.textInputAction = TextInputAction.done,
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.maxLenght,
    this.focusedborder,
    this.textStyle,
    this.fem = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !isEnabled,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.75,
        child: Container(
          padding: EdgeInsets.only(
            left: 24,
            right: 12,
            top: 4 * fem,
            bottom: 4 * fem,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffededf1),
            ),
            borderRadius: BorderRadius.circular(60),
          ),
          child: TextFormField(
            maxLength: maxLenght,
            textAlign: textAlign,
            onTap: onTap,
            onChanged: onChange,
            controller: controller,
            autocorrect: autocorrect,
            readOnly: readOnly,
            textCapitalization: textCapitalization,
            enableSuggestions: enableSuggestions,
            inputFormatters: mask != null ? [mask!] : null,
            focusNode: focusNode,
            maxLines: maxLines,
            minLines: minLines,
            obscureText: obscureText,
            onFieldSubmitted: onSubmitted,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            validator: validator,
            style: textStyle ??
                Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 14 * fem,
                    ),
            decoration: InputDecoration(
              // counter: const SizedBox.shrink(),
              errorText: errorText,
              errorStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.red,
                    fontSize: 11 * fem,
                  ),
              errorMaxLines: 3,
              labelText: label,
              hintText: placeholder,
              contentPadding: padding,
              labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 12 * fem,
                  ),
              hintStyle: Theme.of(context).textTheme.titleLarge,
              suffixIcon: suffixIcon != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40 * fem,
                          width: 40 * fem,
                          child: suffixIcon,
                        )
                      ],
                    )
                  : null,
              prefixIcon: prefixIcon != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [SizedBox(height: 20, width: 20, child: prefixIcon)],
                    )
                  : null,
              border: border(context),
              enabledBorder: focusedborder ?? border(context),
              focusedBorder: focusedborder ?? border(context),
              errorBorder: border(context, color: Colors.red),
              focusedErrorBorder: border(context, color: Colors.red),
              disabledBorder: border(
                context,
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputBorder border(BuildContext context, {Color? color}) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color ?? Theme.of(context).cardColor,
      ),
    );
  }
}
