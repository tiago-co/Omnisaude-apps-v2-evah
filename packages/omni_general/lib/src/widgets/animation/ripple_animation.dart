import 'dart:async';

import 'package:flutter/material.dart';

class RippleAnimation extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final double minRadius;
  Color color;
  final int ripplesCount;
  final Duration duration;
  final bool repeat;

  RippleAnimation({
    Key? key,
    required this.child,
    this.color = Colors.white,
    this.delay = const Duration(seconds: 1),
    this.repeat = true,
    this.minRadius = 50,
    this.ripplesCount = 3,
    this.duration = const Duration(milliseconds: 1500),
  }) : super(key: key);

  @override
  _RippleAnimationState createState() => _RippleAnimationState();
}

class _RippleAnimationState extends State<RippleAnimation>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    Timer(widget.delay, () {
      widget.repeat ? _controller?.repeat() : _controller?.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(
        _controller,
        color: widget.color,
        minRadius: widget.minRadius,
        wavesCount: widget.ripplesCount + 2,
      ),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter(
    this._animation, {
    this.minRadius,
    this.wavesCount,
    required this.color,
  }) : super(repaint: _animation);
  final Color color;
  final double? minRadius;
  final wavesCount;
  final Animation<double>? _animation;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = 0; wave <= wavesCount; wave++) {
      circle(canvas, rect, minRadius, wave, _animation!.value, wavesCount);
    }
  }

  void circle(Canvas canvas, Rect rect, double? minRadius, int wave,
      double value, int? length) {
    Color _color;
    double r;
    if (wave != 0) {
      final double opacity =
          (1 - ((wave - 1) / length!) - value).clamp(0.0, 1.0);
      _color = color.withOpacity(opacity);

      r = minRadius! * (1 + ((wave * value))) * value;
      final Paint paint = Paint()..color = _color;
      canvas.drawCircle(rect.center, r, paint);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;
}
