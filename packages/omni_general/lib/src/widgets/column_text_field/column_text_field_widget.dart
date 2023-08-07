import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ColumnTextFieldWidget<T> extends StatefulWidget {
  final String label;
  final TextEditingController? textEditingController;
  final Function? updateAddressFields;
  final MaskTextInputFormatter? mask;
  final String? value;
  final bool readOnly;
  final String headerTitle;
  final String placeholder;
  final String textLabelField;
  final List<T>? items;
  final void Function()? onTap;
  final List<String> itemsLabels;
  final Map<String, dynamic> Function(String)? onChangeField;

  const ColumnTextFieldWidget({
    Key? key,
    this.value,
    this.label = '',
    this.onChangeField,
    this.placeholder = '',
    this.readOnly = false,
    this.textEditingController,
    this.items = const [],
    this.itemsLabels = const [],
    required this.textLabelField,
    this.headerTitle = 'Editar',
    this.updateAddressFields,
    this.mask,
    this.onTap,
  }) : super(key: key);

  @override
  State<ColumnTextFieldWidget<T>> createState() =>
      _IncomeTaxItemTextFieldState<T>();
}

class _IncomeTaxItemTextFieldState<T> extends State<ColumnTextFieldWidget<T>> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            widget.textLabelField,
            softWrap: false,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).cardColor,
                  fontSize: 15,
                ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            child: SelectableText(
              widget.value ?? '-',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
