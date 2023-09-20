import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/core/models/reset_password_model.dart';
import 'package:omni_auth/src/modules/reset_password/reset_password_store.dart';
import 'package:omni_auth/src/modules/reset_password/widgets/reset_password_header_widget.dart';
import 'package:omni_auth/src/modules/reset_password/widgets/token_form_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_reset_password_labels/labels.dart';

class VerificationTokenPage extends StatelessWidget {
  final PageController pageController;
  VerificationTokenPage({
    Key? key,
    required this.pageController,
  }) : super(key: key);
  final ResetPasswordStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();

    return Column(
      children: [
        const ResetPasswordHeaderWidget(),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Form(
              key: formKey,
              child: TokenFormWidget(),
            ),
          ),
        ),
        TripleBuilder<ResetPasswordStore, Exception, ResetPasswordModel>(
          store: store,
          builder: (_, triple) {
            return BottomButtonWidget(
              isDisabled: store.isDisabled(page: 1),
              onPressed: () async {
                switch (pageController.page!.round().toInt()) {
                  case 0:
                    await store.getAccessToken(store.state).then((value) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.decelerate,
                      );
                    }).catchError(
                      (onError) async {},
                    );
                    break;
                  case 1:
                    await store.validateAccessToken(store.state).then((value) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.decelerate,
                      );
                    }).catchError(
                      (onError) async {
                        Helpers.showDialog(
                          context,
                          RequestErrorWidget(
                            message: ResetPasswordLabels
                                .verificationTokenRequestErrorMessage,
                            onPressed: () {
                              store.state.token = '';

                              Modular.to.pop();
                            },
                            buttonText: ResetPasswordLabels.close,
                          ),
                        );
                      },
                    );
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
