import 'package:flutter/material.dart';
import 'package:omni_reset_password_labels/labels.dart';

class ResetPasswordHeaderWidget extends StatelessWidget {
  const ResetPasswordHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          ResetPasswordLabels.resetPasswordHeaderRecover,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 5),
        Text(
          ResetPasswordLabels.resetPasswordHeaderPassword,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 15),
        Text(
          ResetPasswordLabels.resetPasswordHeaderData,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          ResetPasswordLabels.resetPasswordHeaderChange,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
