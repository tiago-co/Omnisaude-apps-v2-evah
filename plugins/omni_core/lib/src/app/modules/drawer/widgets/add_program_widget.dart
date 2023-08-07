import 'package:drawer_labels/labels.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/drawer/stores/add_program_store.dart';
import 'package:omni_general/omni_general.dart';

class AddProgramWidget extends StatefulWidget {
  const AddProgramWidget({Key? key}) : super(key: key);

  @override
  _AddProgramWidgetState createState() => _AddProgramWidgetState();
}

class _AddProgramWidgetState extends State<AddProgramWidget> {
  final AddProgramStore store = Modular.get();
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
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
                title: DrawerLabels.addProgramTitle,
              ),
              _buildProgramCodeFormWidget,
            ],
          ),
        ),
        const SizedBox(height: 5),
        TripleBuilder(
          store: store,
          builder: (_, triple) {
            return BottomButtonWidget(
              onPressed: () async {
                final Map<String, String> data = {
                  'codigo_psp': textController.text,
                };
                await store.addNewProgram(data).then((value) {
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
              },
              isLoading: triple.isLoading,
              isDisabled: store.isDisabled,
              buttonType: BottomButtonType.outline,
              text: DrawerLabels.addProgramAddProgram,
            );
          },
        ),
      ],
    );
  }

  Widget get _buildProgramCodeFormWidget {
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
                  label: DrawerLabels.addProgramCodeLabel,
                  placeholder: DrawerLabels.addProgramCodePlaceholder,
                  textCapitalization: TextCapitalization.characters,
                  onChange: store.onChangeTextFieldValue,
                  suffixIcon: SvgPicture.asset(
                    Assets.add,
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
      child: TripleBuilder<AddProgramStore, Exception, String>(
        store: store,
        builder: (_, triple) {
          return ExcludeSemantics(
            child: AbsorbPointer(
              absorbing: triple.state.isEmpty,
              child: Opacity(
                opacity: triple.state.isEmpty ? 0.5 : 1.0,
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
                      text: DrawerLabels.addProgramTermsAccept,
                      style: Theme.of(context).textTheme.titleLarge,
                      children: [
                        TextSpan(
                          text: DrawerLabels.addProgramTermsConditions,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Modular.to.pushNamed(
                                '/terms',
                                arguments: textController.text,
                              );
                            },
                        ),
                        const TextSpan(
                          text: DrawerLabels.addProgramTermsProgram,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
