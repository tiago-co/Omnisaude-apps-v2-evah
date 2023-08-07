import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/src/core/enums/buttons_enum.dart';

class BottomButtonWidget extends StatelessWidget {
  final BottomButtonType buttonType;
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final bool isDisabled;
  final bool isBottomSafe;

  const BottomButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.isDisabled = false,
    this.isBottomSafe = true,
    this.buttonType = BottomButtonType.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isLoading) const SizedBox(height: 1.5),
        if (!isLoading) const Divider(height: 0),
        if (isLoading)
          LinearProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
            color: Theme.of(context).colorScheme.background,
            minHeight: 1.5,
          ),
        TextButton(
          onPressed: isDisabled || isLoading ? null : onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
              buttonType == BottomButtonType.primary
                  ? Theme.of(context).primaryColor.withOpacity(
                        isDisabled || isLoading ? 0.5 : 1.0,
                      )
                  : Colors.white,
            ),
            overlayColor: MaterialStateProperty.all(
              buttonType == BottomButtonType.primary
                  ? Colors.white.withOpacity(0.1)
                  : Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            minimumSize: MaterialStateProperty.all(
              const Size(double.infinity, 60),
            ),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
          ),
          child: Opacity(
            opacity: isDisabled || isLoading ? 0.5 : 1.0,
            child: SafeArea(
              top: false,
              bottom: isBottomSafe,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(width: 15),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: buttonType == BottomButtonType.primary
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: SvgPicture.asset(
                      Assets.arrowRight,
                      package: AssetsPackage.omniGeneral,
                      color: buttonType == BottomButtonType.primary
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      width: 15,
                      height: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
