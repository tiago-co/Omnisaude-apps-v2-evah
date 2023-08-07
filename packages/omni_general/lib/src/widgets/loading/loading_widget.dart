import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool isStretch;
  final Color color;
  final Color? indicatorColor;
  const LoadingWidget({
    Key? key,
    this.isStretch = true,
    this.color = Colors.transparent,
    this.indicatorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ColoredBox(
          color: color,
          child: Column(
            crossAxisAlignment: isStretch
                ? CrossAxisAlignment.stretch
                : CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircularProgressIndicator(
                    color: indicatorColor ?? Theme.of(context).primaryColor,
                    strokeWidth: 1.5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
