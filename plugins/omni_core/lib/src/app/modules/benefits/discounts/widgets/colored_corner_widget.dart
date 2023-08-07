import 'dart:math' as math;

import 'package:flutter/material.dart';

class ColoredCornerWidget extends StatelessWidget {
  final Color color;
  final double size;
  final Widget child;
  final IconData icon;
  final String discountPercentage;

  const ColoredCornerWidget({
    this.color = Colors.red,
    this.size = 70,
    required this.child,
    this.icon = Icons.home,
    required this.discountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 0,
          right: 0,
          child: CustomPaint(
            painter: _TrianglePainter(color),
            size: Size(size, size),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Transform.rotate(
            angle: math.pi / 4,
            child: Text(
              'Até \n $discountPercentage% off',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TrianglePainter oldDelegate) => false;
}
