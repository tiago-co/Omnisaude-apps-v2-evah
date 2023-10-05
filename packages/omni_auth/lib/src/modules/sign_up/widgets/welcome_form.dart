import 'package:flutter/material.dart';
import 'package:omni_auth/src/modules/sign_up/widgets/welcome_form_field.dart';

class WelcomeForm extends StatelessWidget {
  const WelcomeForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return const Column(
      children: [
        WelcomeFormField(
          label: 'CPF',
        ),
        SizedBox(
          height: 12,
        ),
        WelcomeFormField(
          label: 'E-mail',
        ),
        SizedBox(
          height: 12,
        ),
        WelcomeFormField(
          label: 'Primeiro nome',
        ),
      ],
    );
  }
}
