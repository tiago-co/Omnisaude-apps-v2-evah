import 'package:flutter/material.dart';
import 'package:omni_general/src/core/enums/buttons_enum.dart';

class RoundedButtonWidget extends StatelessWidget {
  final DefaultButtonType buttonType;
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final bool isDisabled;
  final double borderRadius;

  const RoundedButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    this.borderRadius = 20,
    this.isLoading = false,
    this.isDisabled = false,
    this.buttonType = DefaultButtonType.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case DefaultButtonType.primary:
        return _buildPrimaryButton(context);
      case DefaultButtonType.outline:
        return _buildOutlinedButton(context);
    }
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return TextButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(
          Theme.of(context).primaryColor.withOpacity(
                isDisabled || isLoading || onPressed == null ? 0.5 : 1.0,
              ),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
        side: MaterialStateProperty.all(
          BorderSide(color: Theme.of(context).primaryColor, width: 0.5),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        overlayColor: MaterialStateProperty.all(
          Colors.white.withOpacity(0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLoading
            ? const CircularProgressIndicator.adaptive()
            : Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
      ),
    );
  }

  Widget _buildOutlinedButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: OutlinedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          side: MaterialStateProperty.all(
            BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(
                    isDisabled || isLoading || onPressed == null ? 0.5 : 1.0,
                  ),
              width: 0.5,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          overlayColor: MaterialStateProperty.all(
            Theme.of(context).primaryColor.withOpacity(0.05),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator.adaptive()
            : Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).primaryColor.withOpacity(
                            isDisabled || isLoading || onPressed == null
                                ? 0.5
                                : 1.0,
                          ),
                    ),
              ),
      ),
    );
  }
}
