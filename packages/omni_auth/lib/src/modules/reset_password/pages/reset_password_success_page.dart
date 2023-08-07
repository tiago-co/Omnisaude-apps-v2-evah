import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart'
    show BottomButtonType, BottomButtonWidget, SuccessWidget;
import 'package:omni_reset_password_labels/labels.dart';

class ResetPasswordSuccessPage extends StatelessWidget {
  const ResetPasswordSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (_, constrains) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: constrains.maxWidth * 0.05,
                  ),
                  constraints: BoxConstraints(
                    minHeight: constrains.maxHeight,
                  ),
                  alignment: Alignment.center,
                  child: Center(
                    child: Column(
                      children: [
                        const SuccessWidget(),
                        const SizedBox(height: 15),
                        Text(
                          ResetPasswordLabels.successMessage,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        BottomButtonWidget(
          onPressed: () {
            Modular.to.pushReplacementNamed('../login');
          },
          buttonType: BottomButtonType.outline,
          text: ResetPasswordLabels.successLoginButton,
        ),
      ],
    );
  }
}
