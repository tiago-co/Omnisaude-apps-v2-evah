import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:omni_caregiver/src/caregiver_details/stores/caregiver_details_store.dart';
import 'package:omni_caregiver_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';

class CaregiverFieldInfoWidget extends StatefulWidget {
  final bool readOnly;
  final String label;
  final String? value;
  final Map<String, dynamic> Function(String)? onChangeField;
  final MaskTextInputFormatter? mask;
  final String? Function(String?)? validator;
  final bool showAll;

  const CaregiverFieldInfoWidget({
    Key? key,
    required this.label,
    this.value,
    this.showAll = false,
    this.onChangeField,
    this.readOnly = false,
    this.mask,
    this.validator,
  }) : super(key: key);

  @override
  _CaregiverFieldInfoWidgetState createState() =>
      _CaregiverFieldInfoWidgetState();
}

class _CaregiverFieldInfoWidgetState extends State<CaregiverFieldInfoWidget> {
  final CaregiverDetailsStore store = Modular.get();
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: widget.readOnly
              ? null
              : () async {
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
                      widget.label,
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
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          child: Text(
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
            builder: (_, triple) => _build(_, triple.isLoading),
          ),
        ),
        const SizedBox(height: 5),
        TripleBuilder(
          store: store,
          builder: (_, triple) {
            return BottomButtonWidget(
              isLoading: triple.isLoading,
              buttonType: BottomButtonType.outline,
              onPressed: () async {
                await store
                    .updateField(
                  widget.onChangeField!(
                    textEditingController.text,
                  ),
                )
                    .whenComplete(() {
                  Modular.to.pop();
                }).catchError((onError) {
                  Helpers.showDialog(
                    context,
                    RequestErrorWidget(
                      error: onError,
                      buttonText: CaregiverLabels.close,
                      onPressed: () => Modular.to.pop(),
                    ),
                  );
                });
              },
              text: CaregiverLabels.caregiverDetailsChange,
            );
          },
        ),
      ],
    );
  }

  Widget _build(BuildContext context, bool isLoading) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const BottomSheetHeaderWidget(
          title: CaregiverLabels.caregiverDetailsChangeName,
        ),
        AbsorbPointer(
          absorbing: isLoading,
          child: Opacity(
            opacity: isLoading ? 0.5 : 1,
            child: TextFieldWidget(
              validator: (String? input) {
                if (input!.length > 8 && input.length < 11) {
                  return null;
                } else {
                  return CaregiverLabels.caregiverDetailsInvalidPhone;
                }
              },
              mask: widget.mask,
              label: widget.label,
              placeholder: widget.label,
              controller: textEditingController,
            ),
          ),
        ),
      ],
    );
  }
}
