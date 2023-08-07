import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:omni_core/src/app/core/enums/profile_enum.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/profile/profile_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:profile_labels/labels.dart';

class ProfileMenuItemWidget<T> extends StatefulWidget {
  final String label;
  final TextEditingController textEditingController;
  final TextEditingController? jsonValueController;
  final Function? updateAddressFields;
  final MaskTextInputFormatter? mask;
  final bool isCEP;
  final String? value;
  final bool readOnly;
  final String headerTitle;
  final String placeholder;
  final String textLabelField;
  final List<T>? items;
  final void Function(T)? onSelectItem;
  final List<String> itemsLabels;
  final ProfileMenuItemType menuType;
  final Map<String, dynamic> Function(String)? onChangeField;
  final bool reverse;

  const ProfileMenuItemWidget({
    Key? key,
    this.value,
    this.label = '',
    this.onChangeField,
    this.placeholder = '',
    this.readOnly = false,
    this.isCEP = false,
    required this.textEditingController,
    this.items = const [],
    this.itemsLabels = const [],
    required this.textLabelField,
    this.headerTitle = 'Editar',
    this.menuType = ProfileMenuItemType.text,
    this.updateAddressFields,
    this.mask,
    this.onSelectItem,
    this.jsonValueController,
    this.reverse = true,
  }) : super(key: key);

  @override
  State<ProfileMenuItemWidget<T>> createState() =>
      _ProfileMenuItemWidgetState<T>();
}

class _ProfileMenuItemWidgetState<T> extends State<ProfileMenuItemWidget<T>> {
  final ProfileStore store = Modular.get();
  final GlobalKey<FormState> formKey = GlobalKey();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    widget.textEditingController.text = widget.value ?? '';
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.reset();
    widget.textEditingController.dispose();
    //widget.jsonValueController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: widget.readOnly
              ? null
              : () async {
                  focusNode.requestFocus();
                  await showModalBottomSheet(
                    context: context,
                    enableDrag: true,
                    isScrollControlled: true,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    builder: (_) => _buildSheetWidget(_),
                  );
                },
          borderRadius: BorderRadius.circular(5),
          highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
          splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
          child: Padding(
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
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
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
                            parent: NeverScrollableScrollPhysics(),
                          ),
                          reverse: widget.reverse,
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            widget.value ?? '-',
                            softWrap: true,
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
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset(
                        Assets.arrowRight,
                        package: AssetsPackage.omniGeneral,
                        color: Theme.of(context).primaryColor,
                        height: 15,
                        width: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildSheetWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom >= 60
                ? MediaQuery.of(context).viewInsets.bottom - 60
                : 0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: TripleBuilder(
            store: store,
            builder: (_, triple) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const BottomSheetHeaderWidget(title: 'Alterar perfil'),
                  IgnorePointer(
                    ignoring: triple.isLoading,
                    child: Opacity(
                      opacity: triple.isLoading ? 0.5 : 1,
                      child: Form(
                        key: formKey,
                        child: _buildFieldWidget(widget.menuType),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        TripleBuilder(
          store: store,
          builder: (_, triple) {
            return BottomButtonWidget(
              isLoading: triple.isLoading,
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                if (widget.onChangeField == null) return;
                if (!widget.isCEP) {
                  String value;
                  if (widget.menuType == ProfileMenuItemType.select) {
                    value = widget.jsonValueController!.text;
                  } else {
                    value = widget.textEditingController.text;
                  }
                  await store
                      .updateField(
                    widget.onChangeField!(value),
                  )
                      .then((value) {
                    Modular.to.pop();
                  }).catchError((onError) {
                    Helpers.showDialog(
                      context,
                      RequestErrorWidget(
                        error: onError,
                        buttonText: ProfileLabels.close,
                        onPressed: () => Modular.to.pop(),
                      ),
                    );
                  });
                } else {
                  await store
                      .updateAddressByCep(
                    widget.onChangeField!(widget.textEditingController.text),
                    widget.updateAddressFields!,
                  )
                      .then((value) {
                    Modular.to.pop();
                  }).catchError((onError) {
                    Helpers.showDialog(
                      context,
                      RequestErrorWidget(
                        error: onError,
                        buttonText: ProfileLabels.close,
                        onPressed: () => Modular.to.pop(),
                      ),
                    );
                  });
                }
              },
              text: ProfileLabels.profileMenuItemChange,
            );
          },
        ),
      ],
    );
  }

  Widget _buildFieldWidget(ProfileMenuItemType menuType) {
    switch (menuType) {
      case ProfileMenuItemType.date:
        return TextFieldWidget(
          label: widget.label,
          placeholder: widget.placeholder,
          controller: widget.textEditingController,
          validator: Validators.emptyField,
          readOnly: true,
          suffixIcon: const Icon(Icons.date_range),
          onTap: () async {
            await DateTimePickerService()
                .selectDate(
              context,
              maxDate: DateTime.now(),
              enablePastDates: true,
            )
                .then(
              (dateTime) {
                if (dateTime == null) return;
                widget.textEditingController.text =
                    Formaters.dateToStringDate(dateTime);
              },
            );
          },
        );
      case ProfileMenuItemType.select:
        return SelectFieldWidget<T>(
          label: widget.label,
          placeholder: widget.placeholder,
          controller: widget.textEditingController,
          items: widget.items!,
          itemsLabels: widget.itemsLabels,
          validator: Validators.emptyField,
          onSelectItem: widget.onSelectItem!,
        );
      default:
        return TextFieldWidget(
          label: widget.label,
          mask: widget.mask,
          placeholder: widget.placeholder,
          controller: widget.textEditingController,
          focusNode: focusNode,
          validator: Validators.emptyField,
          suffixIcon: const Icon(Icons.description),
        );
    }
  }
}
