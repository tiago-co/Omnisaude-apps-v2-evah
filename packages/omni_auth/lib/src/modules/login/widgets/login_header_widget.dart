import 'package:flutter/material.dart';
import 'package:omni_login_labels/labels.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          LoginLabels.letsGo,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 15),
        Text(
          LoginLabels.hintText,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
