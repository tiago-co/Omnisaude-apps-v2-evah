import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/core/models/reset_password_model.dart';
import 'package:omni_auth/src/modules/reset_password/reset_password_store.dart';
import 'package:omni_auth/src/modules/reset_password/widgets/reset_password_header_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_reset_password_labels/labels.dart';

class SendPersonalDataPage extends StatelessWidget {
  final PageController pageController;
  SendPersonalDataPage({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final ResetPasswordStore store = Modular.get();
  final TextEditingController cpfController = TextEditingController();
  final FocusNode cpfFocus = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey();
  final mask = Masks.generateMask('###.###.###-##');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ResetPasswordHeaderWidget(),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.15,
              vertical: 15,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  TextFieldWidget(
                    label: ResetPasswordLabels.sendPersonalDataCPFLabel,
                    placeholder:
                        ResetPasswordLabels.sendPersonalDataCPFPlaceholder,
                    controller: cpfController,
                    focusNode: cpfFocus,
                    onSubmitted: (String input) {
                      Helpers.changeFocus(context, cpfFocus, emailFocus);
                    },
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                    mask: mask,
                    keyboardType: TextInputType.number,
                    validator: (cpf) {
                      if (Helpers.cpfIsValid(cpf.toString())) {
                        return null;
                      } else {
                        return ResetPasswordLabels.sendPersonalDataCPFError;
                      }
                    },
                    onChange: (String? input) {
                      store.state.cpf = input;
                      store.updateForm(store.state);
                    },
                  ),
                  const SizedBox(height: 25),
                  TextFieldWidget(
                    label: ResetPasswordLabels.sendPersonalDataEmailLabel,
                    placeholder:
                        ResetPasswordLabels.sendPersonalDataEmailPlaceholder,
                    controller: emailController,
                    focusNode: emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                    validator: (email) {
                      if (email!.isNotEmpty) {
                        return null;
                      } else {
                        return ResetPasswordLabels.emptyFieldError;
                      }
                    },
                    onChange: (String? input) {
                      store.state.email = input!.replaceAll('.', '');
                      store.state.email = input.replaceAll('-', '');
                      store.updateForm(store.state);
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                ],
              ),
            ),
          ),
        ),
        TripleBuilder<ResetPasswordStore, Exception, ResetPasswordModel>(
          store: store,
          builder: (_, triple) {
            return BottomButtonWidget(
              isDisabled: store.isDisabled(page: 0),
              onPressed: () async {
                switch (pageController.page!.round().toInt()) {
                  case 0:
                    if (formKey.currentState!.validate()) {
                      await store.getAccessToken(store.state).then(
                        (value) {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.decelerate,
                          );
                        },
                      ).catchError(
                        (onError) async {
                          Helpers.showDialog(
                            context,
                            RequestErrorWidget(
                              message: ResetPasswordLabels
                                  .sendPersonalDataRequestErrorMessage,
                              onPressed: () => Modular.to.pop(),
                              buttonText: ResetPasswordLabels.close,
                            ),
                          );
                        },
                      );
                    }
                    break;
                }
              },
              isLoading: triple.isLoading,
              buttonType: BottomButtonType.outline,
              text: ResetPasswordLabels.continueMessage,
            );
          },
        ),
      ],
    );
  }
}
