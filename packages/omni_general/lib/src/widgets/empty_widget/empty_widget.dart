import 'package:flutter/material.dart';
import 'package:omni_general/omni_general.dart';

class EmptyWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? textButton;
  final bool isLoading;
  final bool isDisabled;
  final String message;

  const EmptyWidget({
    Key? key,
    this.onPressed,
    this.textButton,
    this.isLoading = false,
    this.isDisabled = false,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(),
        ),
        if (onPressed != null && textButton != null) const SizedBox(height: 15),
        if (onPressed != null && textButton != null)
          DefaultButtonWidget(
            onPressed: onPressed,
            text: textButton!,
            isDisabled: isDisabled,
            isLoading: isLoading,
          ),
      ],
    );
  }
}
