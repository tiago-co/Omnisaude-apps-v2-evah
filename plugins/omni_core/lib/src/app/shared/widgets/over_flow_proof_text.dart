import 'package:flutter/widgets.dart';

class OverflowProofText extends StatelessWidget {
  final Text text;
  final Widget fallback;

  const OverflowProofText({
    required this.text,
    required this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints size) {
          final TextPainter painter = TextPainter(
            maxLines: 1,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
            text: TextSpan(
              style: text.style ?? DefaultTextStyle.of(context).style,
              text: text.data,
            ),
          );

          painter.layout(maxWidth: size.maxWidth);

          return painter.didExceedMaxLines ? fallback : text;
        },
      ),
    );
  }
}
