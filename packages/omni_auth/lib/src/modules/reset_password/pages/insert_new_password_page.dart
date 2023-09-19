import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/core/models/reset_password_model.dart';
import 'package:omni_auth/src/modules/reset_password/reset_password_store.dart';
import 'package:omni_auth/src/modules/reset_password/widgets/reset_password_header_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_reset_password_labels/labels.dart';

class InsertNewPasswordPage extends StatelessWidget {
  InsertNewPasswordPage({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;
  final ResetPasswordStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    final TextEditingController newPasswordController = TextEditingController();
    final FocusNode newPasswordFocus = FocusNode();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final FocusNode confirmPasswordFocus = FocusNode();
    final GlobalKey<FormState> formKey = GlobalKey();
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
                    maxLines: 1,
                    obscureText: true,
                    label:
                        ResetPasswordLabels.insertNewPasswordNewPasswordLabel,
                    placeholder: ResetPasswordLabels
                        .insertNewPasswordNewPasswordPlaceholder,
                    controller: newPasswordController,
                    focusNode: newPasswordFocus,
                    onSubmitted: (String input) {
                      Helpers.changeFocus(
                        context,
                        newPasswordFocus,
                        confirmPasswordFocus,
                      );
                    },
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                    validator: (novaSenha) {
                      if (novaSenha!.isNotEmpty) {
                        return null;
                      } else {
                        return ResetPasswordLabels.emptyFieldError;
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  TextFieldWidget(
                    maxLines: 1,
                    obscureText: true,
                    label: ResetPasswordLabels
                        .insertNewPasswordConfirmPasswordLabel,
                    placeholder: ResetPasswordLabels
                        .insertNewPasswordConfirmPasswordPlaceholder,
                    controller: confirmPasswordController,
                    focusNode: confirmPasswordFocus,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                    validator: (confirmPassword) {
                      if (confirmPassword == confirmPassword) {
                        return null;
                      } else {
                        return ResetPasswordLabels
                            .insertNewPasswordInequalityError;
                      }
                    },
                    onChange: (String? input) {
                      store.state.password = input;
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
              isDisabled: store.isDisabled(page: 2),
              onPressed: () async {
                switch (pageController.page!.round()) {
                  case 2:
                    if (formKey.currentState!.validate()) {
                      await store.resetPassword(store.state).then(
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
                                  .insertNewPasswordRequestErrorMessage,
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
