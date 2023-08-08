import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/register/pages/access_data_form_page.dart';
import 'package:omni_auth/src/modules/register/pages/address_form_page.dart';
import 'package:omni_auth/src/modules/register/pages/personal_data_form_page.dart';
import 'package:omni_auth/src/modules/register/pages/program_form_page.dart';
import 'package:omni_auth/src/modules/register/pages/register_success_page.dart';
import 'package:omni_auth/src/modules/register/pages/verify_personal_data_page.dart';
import 'package:omni_auth/src/modules/register/stores/register_store.dart';
import 'package:omni_auth/src/shared/widgets/auth_nav_bar_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterStore store = Modular.get();
  final PageController pageController = PageController();
  VoidCallback? onLeadingPress;

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        onLeadingPress = (pageController.page == 0 || pageController.page == 5)
            ? null
            : () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                );
              };
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthNavBarWidget(
        onLeadingPress: onLeadingPress,
      ).build(context) as AppBar,
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
                      VerifyPersonalDataPage(pageController: pageController),
                      ProgramFormPage(pageController: pageController),
                      // PersonalDataFormPage(pageController: pageController),
                      AddressFormPage(pageController: pageController),
                      AccessDataFormPage(pageController: pageController),
                      const RegisterSuccessPage(),
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
