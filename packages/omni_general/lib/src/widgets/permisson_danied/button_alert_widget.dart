import 'package:flutter/material.dart';

class ButtonAlertWidget extends StatefulWidget {
  final String? text;
  final void Function()? onPressed;
  final bool? invertedColors;
  final Color? primaryColor;
  final Color? accentColor;
  const ButtonAlertWidget({
    Key? key,
    this.text,
    required this.onPressed,
    this.invertedColors = false,
    required this.primaryColor,
    this.accentColor = Colors.white,
  }) : super(key: key);

  @override
  State<ButtonAlertWidget> createState() => _ButtonAlertWidgetState();
}

class _ButtonAlertWidgetState extends State<ButtonAlertWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        alignment: Alignment.center,
        side: MaterialStateProperty.all(
          BorderSide(color: widget.primaryColor!),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.only(right: 25, left: 25),
        ),
        backgroundColor: MaterialStateProperty.all(
          widget.invertedColors! ? widget.accentColor : widget.primaryColor,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      onPressed: widget.onPressed,
      child: Text(
        widget.text!,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: widget.invertedColors!
                  ? widget.primaryColor
                  : widget.accentColor,
            ),
      ),
    );
  }
}
