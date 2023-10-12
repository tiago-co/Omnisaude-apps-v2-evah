import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/register/stores/register_store.dart';

import 'package:omni_general/omni_general.dart';

class WelcomeForm extends StatelessWidget {
  WelcomeForm({Key? key}) : super(key: key);
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final RegisterStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Column(
      children: [
        TextFieldWidget(
          label: 'Username',
          controller: username,
          focusedborder: InputBorder.none,
          padding: EdgeInsets.zero,
          onChange: (String? input) {
            store.state.individualPerson?.user?.username = input;
            store.updateForm(store.state);
          },
        ),
        SizedBox(
          height: 12,
        ),
        TextFieldWidget(
          label: 'E-mail',
          controller: email,
          focusedborder: InputBorder.none,
          padding: EdgeInsets.zero,
          onChange: (String? input) {
            store.state.individualPerson?.user?.email = input;
            store.updateForm(store.state);
          },
        ),
        SizedBox(
          height: 12,
        ),
        TextFieldWidget(
          label: 'Senha',
          controller: password,
          focusedborder: InputBorder.none,
          padding: EdgeInsets.zero,
          onChange: (String? input) {
            store.state.individualPerson?.user?.password = input;
            store.updateForm(store.state);
          },
        ),
      ],
    );
  }
}
