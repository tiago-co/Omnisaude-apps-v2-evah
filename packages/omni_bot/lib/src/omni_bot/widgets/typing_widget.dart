import 'package:flutter/material.dart';

class TypingWidget extends StatefulWidget {
  final bool isTyping;
  const TypingWidget({Key? key, this.isTyping = false}) : super(key: key);

  @override
  _TypingWidgetState createState() => _TypingWidgetState();
}

class _TypingWidgetState extends State<TypingWidget> {
  final Duration duration = const Duration(milliseconds: 2050);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        final Animation<Offset> offset = Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: animation, curve: Curves.decelerate),
        );
        final Animation<double> opacity = Tween<double>(
          begin: 1,
          end: 1,
        ).animate(
          CurvedAnimation(parent: animation, curve: Curves.elasticIn),
        );
        return FadeTransition(
          opacity: opacity,
          child: SlideTransition(
            position: offset,
            child: child,
          ),
        );
      },
      child: widget.isTyping
          ? Container(
              key: const ValueKey(1),
              color: Colors.red,
              height: 50,
            )
          : Container(
              key: const ValueKey(2),
              color: Colors.blue,
              height: 50,
            ),
    );
  }
}
