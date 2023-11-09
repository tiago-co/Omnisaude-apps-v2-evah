import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/register/stores/register_store.dart';

import 'package:omni_general/omni_general.dart';

class WelcomeForm extends StatelessWidget {
  WelcomeForm({Key? key}) : super(key: key);
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController cpf = TextEditingController();
  final RegisterStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Column(
      children: [
        TextFieldWidget(
          label: 'Nome',
          controller: name,
          focusedborder: InputBorder.none,
          padding: EdgeInsets.zero,
          // keyboardType: TextInputType.name,
          onChange: (String? input) {
            store.state.individualPerson?.name = input;
            // store.updateForm(store.state);
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
          // keyboardType: TextInputType.emailAddress,
          onChange: (String? input) {
            store.state.individualPerson?.user = UserModel(email: input);
            // store.updateForm(store.state);
          },
        ),
        SizedBox(
          height: 12,
        ),
        TextFieldWidget(
          label: 'CPF',
          controller: cpf,
          focusedborder: InputBorder.none,
          padding: EdgeInsets.zero,
          // mask: Masks.generateMask('###.###.###-##'),
          // keyboardType: TextInputType.number,
          onChange: (String? input) {
            store.state.individualPerson?.cpf = input;
            // store.updateForm(store.state);
          },
        ),
      ],
    );
  }
}
