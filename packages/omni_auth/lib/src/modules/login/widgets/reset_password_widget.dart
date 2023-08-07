import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_login_labels/labels.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed('../resetPassword');
      },
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
      splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
      borderRadius: BorderRadius.circular(5),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          LoginLabels.forgotPassword,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
