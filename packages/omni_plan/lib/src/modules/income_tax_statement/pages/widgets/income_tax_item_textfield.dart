import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:omni_plan/src/modules/income_tax_statement/stores/income_tax_statement_store.dart';

class IncomeTaxItemTextField<T> extends StatefulWidget {
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

  const IncomeTaxItemTextField({
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
  State<IncomeTaxItemTextField<T>> createState() =>
      _IncomeTaxItemTextFieldState<T>();
}

class _IncomeTaxItemTextFieldState<T> extends State<IncomeTaxItemTextField<T>> {
  final IncomeTaxStatementStore store = Modular.get();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    widget.textLabelField,
                    softWrap: false,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).cardColor,
                          fontSize: 15,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        child: widget.onTap == null
                            ? Text(
                                widget.value ?? '-',
                                softWrap: false,
                                textAlign: TextAlign.end,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .cardColor
                                          .withOpacity(0.45),
                                      fontSize: 15,
                                    ),
                              )
                            : GestureDetector(
                                onTap: widget.onTap,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
