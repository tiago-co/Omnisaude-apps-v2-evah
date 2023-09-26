import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/reset_password/reset_password_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_reset_password_labels/labels.dart';

class TokenFormWidget extends StatelessWidget {
  TokenFormWidget({Key? key}) : super(key: key);

  final ResetPasswordStore store = Modular.get();

  final TextEditingController token8 = TextEditingController();

  final FocusNode focusNode8 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                child: TextFieldWidget(
                  label: '',
                  focusedborder: InputBorder.none,
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(fontSize: 25),
                  maxLenght: 8,
                  controller: token8,
                  textCapitalization: TextCapitalization.characters,
                  textInputAction: TextInputAction.next,
                  onChange: (String? input) {
                    store.state.token = token8.text.toUpperCase();
                    store.updateForm(store.state);
                  },
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.13),
          ],
        ),
        Text(
          ResetPasswordLabels.tokenFormCode,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 24,
                color: Theme.of(context).cardColor.withOpacity(0.45),
              ),
        ),
      ],
    );
  }
}
