import 'package:flutter/material.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart'
    show BuildAssetsWidget, DefaultButtonType, DefaultButtonWidget;
import 'package:omni_general_labels/labels.dart';

class SuccessWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final String message;

  const SuccessWidget({
    Key? key,
    this.buttonText = 'Fechar',
    this.onPressed,
    this.message = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Text(
           GeneralLabels.successCongratulations,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: BuildAssetsWidget(
              message: Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                      color: Colors.black,
                    ),
              ),
              assetBase: Assets.successOne,
              asset: Assets.successTwo,
              boxFit: BoxFit.contain,
              width: 10.5,
            ),
          ),
          if (onPressed != null) const SizedBox(height: 15),
          if (onPressed != null)
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
