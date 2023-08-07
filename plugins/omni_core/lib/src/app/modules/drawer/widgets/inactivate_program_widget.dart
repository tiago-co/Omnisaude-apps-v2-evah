import 'package:drawer_labels/labels.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/modules/drawer/stores/inactivate_program_store.dart';
import 'package:omni_general/omni_general.dart';

class InactivateProgramWidget extends StatefulWidget {
  const InactivateProgramWidget({Key? key}) : super(key: key);

  @override
  _InactivateProgramWidgetState createState() =>
      _InactivateProgramWidgetState();
}

class _InactivateProgramWidgetState extends State<InactivateProgramWidget> {
  final InactivateProgramStore store = Modular.get();
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void inactivateProgram() {
    final Map<String, String> data = {'motivo': textController.text};
    store
        .inactivateProgramSelected(
      data,
      store.programStore.programSelected.id!,
    )
        .then((value) {
      Modular.to.pop();
    }).catchError((onError) {
      Helpers.showDialog(
        context,
        RequestErrorWidget(
          error: onError,
          onPressed: () => Modular.to.pop(),
          buttonText: DrawerLabels.close,
        ),
        showClose: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const BottomSheetHeaderWidget(
                title: DrawerLabels.inactiveProgramTitle,
              ),
              _buildInactivateReasonFormWidget,
            ],
          ),
        ),
        const SizedBox(height: 5),
        TripleBuilder(
          store: store,
          builder: (_, triple) {
            return BottomButtonWidget(
              onPressed: inactivateProgram,
              isLoading: triple.isLoading,
              isDisabled: store.isDisabled,
              buttonType: BottomButtonType.outline,
              text: DrawerLabels.inactiveProgramInactive,
            );
          },
        ),
      ],
    );
  }

  Widget get _buildInactivateReasonFormWidget {
    return TripleBuilder(
      store: store,
      builder: (_, triple) {
        return AbsorbPointer(
          absorbing: triple.isLoading,
          child: Opacity(
            opacity: triple.isLoading ? 0.5 : 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFieldWidget(
                  controller: textController,
                  label: DrawerLabels.inactiveProgramReasonLabel,
                  placeholder: DrawerLabels.inactiveProgramReasonPlaceholder,
                  onChange: store.onChangeTextFieldValue,
                  suffixIcon: SvgPicture.asset(
                    Assets.exit,
                    color: Theme.of(context).cardColor,
                    package: AssetsPackage.omniGeneral,
                  ),
                ),
                const SizedBox(height: 10),
                _buildCheckBoxTermsWidget,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget get _buildCheckBoxTermsWidget {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
        splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
      ),
      child: TripleBuilder(
        store: store,
        builder: (_, triple) {
          return ExcludeSemantics(
            child: CheckboxListTile(
              value: store.checkBoxValue,
              onChanged: store.onChangeCheckBoxValue,
              activeColor: Theme.of(context).primaryColor,
              checkColor: Theme.of(context).colorScheme.background,
              controlAffinity: ListTileControlAffinity.leading,
              tileColor: Theme.of(context).cardColor.withOpacity(0.05),
              contentPadding: EdgeInsets.zero,
              title: RichText(
                text: TextSpan(
                  text: DrawerLabels.inactiveProgramTermsAccept,
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                    TextSpan(
                      text: DrawerLabels.inactiveProgramTermsConditions,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Modular.to.pushNamed(
                            '/terms',
                            arguments: store.programStore.programSelected.code,
                          );
                        },
                    ),
                    const TextSpan(
                      text: DrawerLabels.inactiveProgramTermsProgram,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
