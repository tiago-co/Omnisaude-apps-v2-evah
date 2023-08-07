import 'package:flutter/material.dart';

class RetangleMaskPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final backgroundPath = Path()..addRect(Offset.zero & size);

    final left = size.width * 0.15;
    final right = size.width * 0.85;
    final top = size.height * 0.25;
    final bottom = size.height * 0.75;

    const padding = 15.0;
    const lineSize = 30.0;

    final maskPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTRB(left, top, right, bottom),
          const Radius.circular(8),
        ),
      );
    final path =
        Path.combine(PathOperation.difference, backgroundPath, maskPath);

    canvas.drawPath(path, paint);

    final markPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final markPath = Path();

    //Mark top left
    markPath
      ..moveTo(left - padding, top + lineSize)
      ..lineTo(left - padding, top - padding)
      ..lineTo(left + lineSize, top - padding);

    //Mark top right
    markPath
      ..moveTo(right + padding, top + lineSize)
      ..lineTo(right + padding, top - padding)
      ..lineTo(right - lineSize, top - padding);

    //Mark bottom right
    markPath
      ..moveTo(right + padding, bottom - lineSize)
      ..lineTo(right + padding, bottom + padding)
      ..lineTo(right - lineSize, bottom + padding);

    //Mark bottom left
    markPath
      ..moveTo(left - padding, bottom - lineSize)
      ..lineTo(left - padding, bottom + padding)
      ..lineTo(left + lineSize, bottom + padding);

    canvas.drawPath(markPath, markPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
