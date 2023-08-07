import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/reset_password/reset_password_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_reset_password_labels/labels.dart';

class TokenFormWidget extends StatelessWidget {
  const TokenFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ResetPasswordStore store = Modular.get();
    final TextEditingController token1 = TextEditingController();
    final TextEditingController token2 = TextEditingController();
    final TextEditingController token3 = TextEditingController();
    final TextEditingController token4 = TextEditingController();
    final TextEditingController token5 = TextEditingController();
    final TextEditingController token6 = TextEditingController();
    final TextEditingController token7 = TextEditingController();
    final TextEditingController token8 = TextEditingController();

    final FocusNode focusNode1 = FocusNode();
    final FocusNode focusNode2 = FocusNode();
    final FocusNode focusNode3 = FocusNode();
    final FocusNode focusNode4 = FocusNode();
    final FocusNode focusNode5 = FocusNode();
    final FocusNode focusNode6 = FocusNode();
    final FocusNode focusNode7 = FocusNode();
    final FocusNode focusNode8 = FocusNode();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(3),
              width: 35,
              child: TextFieldWidget(
                label: '',
                focusedborder: InputBorder.none,
                textAlign: TextAlign.center,
                maxLenght: 1,
                textStyle: const TextStyle(fontSize: 25),
                controller: token1,
                focusNode: focusNode1,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                onChange: (String? input) {
                  token1.text = input!.toUpperCase();
                  store.state.token = token1.text;
                  store.updateForm(store.state);
                  if (input.isNotEmpty) {
                    Helpers.changeFocus(context, focusNode1, focusNode2);
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(3),
              width: 35,
              child: TextFieldWidget(
                label: '',
                focusedborder: InputBorder.none,
                textAlign: TextAlign.center,
                maxLenght: 1,
                textStyle: const TextStyle(fontSize: 25),
                controller: token2,
                focusNode: focusNode2,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                onChange: (String? input) {
                  token2.text = input!.toUpperCase();
                  store.state.token = store.state.token! + token2.text;
                  store.updateForm(store.state);
                  if (input.isNotEmpty) {
                    Helpers.changeFocus(context, focusNode2, focusNode3);
                  }
                  if (input.isEmpty) {
                    Helpers.changeFocus(context, focusNode2, focusNode1);
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(3),
              width: 35,
              child: TextFieldWidget(
                label: '',
                focusedborder: InputBorder.none,
                textAlign: TextAlign.center,
                maxLenght: 1,
                textStyle: const TextStyle(fontSize: 25),
                controller: token3,
                focusNode: focusNode3,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                onChange: (String? input) {
                  token3.text = input!.toUpperCase();
                  store.state.token = store.state.token! + token3.text;
                  store.updateForm(store.state);
                  if (input.isNotEmpty) {
                    Helpers.changeFocus(context, focusNode3, focusNode4);
                  }
                  if (input.isEmpty) {
                    Helpers.changeFocus(context, focusNode3, focusNode2);
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(3),
              width: 35,
              child: TextFieldWidget(
                label: '',
                focusedborder: InputBorder.none,
                textAlign: TextAlign.center,
                maxLenght: 1,
                textStyle: const TextStyle(fontSize: 25),
                controller: token4,
                focusNode: focusNode4,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                onChange: (String? input) {
                  token4.text = input!.toUpperCase();
                  store.state.token = store.state.token! + token4.text;
                  store.updateForm(store.state);
                  if (input.isNotEmpty) {
                    Helpers.changeFocus(context, focusNode4, focusNode5);
                  }
                  if (input.isEmpty) {
                    Helpers.changeFocus(context, focusNode4, focusNode3);
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(3),
              width: 35,
              child: TextFieldWidget(
                label: '',
                focusedborder: InputBorder.none,
                textAlign: TextAlign.center,
                maxLenght: 1,
                textStyle: const TextStyle(fontSize: 25),
                controller: token5,
                focusNode: focusNode5,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                onChange: (String? input) {
                  token5.text = input!.toUpperCase();
                  store.state.token = store.state.token! + token5.text;
                  store.updateForm(store.state);
                  if (input.isNotEmpty) {
                    Helpers.changeFocus(context, focusNode5, focusNode6);
                  }
                  if (input.isEmpty) {
                    Helpers.changeFocus(context, focusNode5, focusNode4);
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(3),
              width: 35,
              child: TextFieldWidget(
                label: '',
                focusedborder: InputBorder.none,
                textAlign: TextAlign.center,
                maxLenght: 1,
                textStyle: const TextStyle(fontSize: 25),
                controller: token6,
                focusNode: focusNode6,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                onChange: (String? input) {
                  token6.text = input!.toUpperCase();
                  store.state.token = store.state.token! + token6.text;
                  store.updateForm(store.state);
                  if (input.isNotEmpty) {
                    Helpers.changeFocus(context, focusNode6, focusNode7);
                  }
                  if (input.isEmpty) {
                    Helpers.changeFocus(context, focusNode6, focusNode5);
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(3),
              width: 35,
              child: TextFieldWidget(
                label: '',
                focusedborder: InputBorder.none,
                textAlign: TextAlign.center,
                maxLenght: 1,
                textStyle: const TextStyle(fontSize: 25),
                controller: token7,
                focusNode: focusNode7,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                onChange: (String? input) {
                  token7.text = input!.toUpperCase();
                  store.state.token = store.state.token! + token7.text;
                  store.updateForm(store.state);
                  if (input.isNotEmpty) {
                    Helpers.changeFocus(context, focusNode7, focusNode8);
                  }
                  if (input.isEmpty) {
                    Helpers.changeFocus(context, focusNode7, focusNode6);
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.all(3),
              width: 35,
              child: TextFieldWidget(
                label: '',
                focusedborder: InputBorder.none,
                textAlign: TextAlign.center,
                maxLenght: 1,
                textStyle: const TextStyle(fontSize: 25),
                controller: token8,
                focusNode: focusNode8,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                onChange: (String? input) {
                  token8.text = input!.toUpperCase();
                  store.state.token = store.state.token! + token8.text;
                  store.updateForm(store.state);
                  if (input.isNotEmpty) {
                    Helpers.changeFocus(context, focusNode8, focusNode1);
                  }
                  if (input.isEmpty) {
                    Helpers.changeFocus(context, focusNode8, focusNode7);
                  }
                },
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
