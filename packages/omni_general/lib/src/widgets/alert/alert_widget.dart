import 'package:flutter/material.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_general_labels/labels.dart';

class AlertWidget extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  const AlertWidget({
    Key? key,
    required this.message,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 15),
          Text(
            GeneralLabels.alertText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 15),
          Text(
            message,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 15),
          DefaultButtonWidget(
            onPressed: onPressed,
            buttonType: DefaultButtonType.outline,
            text: buttonText,
          )
        ],
      ),
    );
  }
}
