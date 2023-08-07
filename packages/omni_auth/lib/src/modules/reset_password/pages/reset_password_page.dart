import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/reset_password/pages/insert_new_password_page.dart';
import 'package:omni_auth/src/modules/reset_password/pages/reset_password_success_page.dart';
import 'package:omni_auth/src/modules/reset_password/pages/send_personal_data_page.dart';
import 'package:omni_auth/src/modules/reset_password/pages/verification_token_page.dart';
import 'package:omni_auth/src/modules/reset_password/reset_password_store.dart';
import 'package:omni_auth/src/shared/widgets/auth_nav_bar_widget.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final ResetPasswordStore store = Modular.get();
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthNavBarWidget().build(context) as AppBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ColoredBox(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ExcludeSemantics(
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      SendPersonalDataPage(pageController: pageController),
                      VerificationTokenPage(pageController: pageController),
                      InsertNewPasswordPage(pageController: pageController),
                      const ResetPasswordSuccessPage(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
