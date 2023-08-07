import 'package:flutter/material.dart';
import 'package:omni_video_call/src/core/enums/pip_view_corner_enum.dart';
import 'package:omni_video_call/src/video_call/stores/pip_mode_store.dart';

class CornerDistance {
  final PIPViewCorner? corner;
  final double? distance;

  CornerDistance({this.corner, this.distance});
}

class PIPModePage extends StatefulWidget {
  final PIPViewCorner initialCorner;
  final VoidCallback onStartFloating;
  final VoidCallback onStopFloating;
  final double? floatingWidth;
  final double? floatingHeight;
  final int animationDuration;
  final bool avoidKeyboard;

  final Widget Function(
    BuildContext context,
    bool isFloating,
  ) builder;

  const PIPModePage({
    Key? key,
    required this.builder,
    required this.onStartFloating,
    required this.onStopFloating,
    this.initialCorner = PIPViewCorner.topRight,
    this.animationDuration = 500,
    this.floatingWidth,
    this.floatingHeight,
    this.avoidKeyboard = true,
  }) : super(key: key);

  @override
  _PIPModePageState createState() => _PIPModePageState();

  static _PIPModePageState? of(BuildContext context) {
    return context.findAncestorStateOfType<_PIPModePageState>();
  }
}

class _PIPModePageState extends State<PIPModePage>
    with TickerProviderStateMixin {
  final PipModeStore store = PipModeStore();
  late final AnimationController floatingAnimationController;
  late final AnimationController dragAnimationController;
  Map<PIPViewCorner, Offset> _offsets = {};
  Offset _dragOffset = Offset.zero;
  bool _isDragging = false;
  bool _isFloating = false;
  late PIPViewCorner _corner;

  @override
  void initState() {
    super.initState();
    _corner = widget.initialCorner;
    floatingAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration),
    );
    dragAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDuration),
    );
  }

  @override
  void dispose() {
    floatingAnimationController.dispose();
    dragAnimationController.dispose();
    store.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var windowPadding = mediaQuery.padding;
    if (widget.avoidKeyboard) {
      windowPadding += mediaQuery.viewInsets;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        double? floatingWidth = widget.floatingWidth;
        double? floatingHeight = widget.floatingHeight;

        if (floatingWidth == null && floatingHeight != null) {
          floatingWidth = width / height * floatingHeight;
        }
        floatingWidth ??= 100.0;
        floatingHeight ??= height / width * floatingWidth;

        final floatingWidgetSize = Size(floatingWidth, floatingHeight);
        final fullWidgetSize = Size(width, height);

        _updateCornersOffsets(
          spaceSize: fullWidgetSize,
          windowPadding: windowPadding,
          widgetSize: floatingWidgetSize,
        );

        final calculatedOffset = _offsets[_corner];

        // BoxFit.cover
        final widthRatio = floatingWidth / width;
        final heightRatio = floatingHeight / height;
        final scaledDownScale = widthRatio > heightRatio
            ? floatingWidgetSize.width / fullWidgetSize.width
            : floatingWidgetSize.height / fullWidgetSize.height;

        return Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: Listenable.merge([
                floatingAnimationController,
                dragAnimationController,
              ]),
              builder: (context, child) {
                final animationCurve = CurveTween(curve: Curves.easeInOutQuad);
                final dragAnimationValue = animationCurve.transform(
                  dragAnimationController.value,
                );
                final toggleFloatingAnimationValue = animationCurve.transform(
                  floatingAnimationController.value,
                );

                final floatingOffset = _isDragging
                    ? _dragOffset
                    : Tween<Offset>(begin: _dragOffset, end: calculatedOffset)
                        .transform(
                        dragAnimationController.isAnimating
                            ? dragAnimationValue
                            : toggleFloatingAnimationValue,
                      );
                final borderRadius = Tween<double>(begin: 0, end: 10)
                    .transform(toggleFloatingAnimationValue);
                final width = Tween<double>(
                  begin: fullWidgetSize.width,
                  end: floatingWidgetSize.width,
                ).transform(toggleFloatingAnimationValue);
                final height = Tween<double>(
                  begin: fullWidgetSize.height,
                  end: floatingWidgetSize.height,
                ).transform(toggleFloatingAnimationValue);
                final scale = Tween<double>(
                  begin: 1,
                  end: scaledDownScale,
                ).transform(toggleFloatingAnimationValue);

                return Positioned(
                  left: floatingOffset.dx,
                  top: floatingOffset.dy,
                  child: GestureDetector(
                    onPanStart: _isFloating ? _onPanStart : null,
                    onPanUpdate: _isFloating ? _onPanUpdate : null,
                    onPanCancel: _isFloating ? _onPanCancel : null,
                    onPanEnd: _isFloating ? _onPanEnd : null,
                    onTap: _isFloating ? stopFloating : null,
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(borderRadius),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: -5,
                            color: Theme.of(context).cardColor,
                          ),
                        ],
                      ),
                      width: width,
                      height: height,
                      child: Transform.scale(
                        scale: scale,
                        child: OverflowBox(
                          maxHeight: fullWidgetSize.height,
                          maxWidth: fullWidgetSize.width,
                          child: IgnorePointer(
                            ignoring: _isFloating,
                            child: child,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: Builder(
                builder: (context) => widget.builder(context, _isFloating),
              ),
            ),
          ],
        );
      },
    );
  }

  bool _isAnimating() {
    return floatingAnimationController.isAnimating ||
        dragAnimationController.isAnimating;
  }

  void _updateCornersOffsets({
    Size? spaceSize,
    Size? widgetSize,
    EdgeInsets? windowPadding,
  }) {
    _offsets = store.calculateOffsets(
      spaceSize: spaceSize,
      widgetSize: widgetSize,
      windowPadding: windowPadding,
    );
  }

  void dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void startFloating() {
    if (_isAnimating()) return;
    dismissKeyboard(context);
    setState(() => _isFloating = true);
    widget.onStartFloating();
    floatingAnimationController.forward();
  }

  void stopFloating() {
    if (_isAnimating()) return;
    dismissKeyboard(context);
    setState(() => _isFloating = false);
    widget.onStopFloating();
    floatingAnimationController.reverse();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;
    setState(() {
      _dragOffset = _dragOffset.translate(details.delta.dx, details.delta.dy);
    });
  }

  void _onPanCancel() {
    if (!_isDragging) return;
    setState(() {
      dragAnimationController.value = 0;
      _dragOffset = Offset.zero;
      _isDragging = false;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (!_isDragging) return;

    final nearestCorner = store.calculateNearestCorner(
      offset: _dragOffset,
      offsets: _offsets,
    );
    setState(() {
      _corner = nearestCorner;
      _isDragging = false;
    });
    dragAnimationController.forward().whenCompleteOrCancel(() {
      dragAnimationController.value = 0;
      _dragOffset = Offset.zero;
    });
  }

  void _onPanStart(DragStartDetails details) {
    if (_isAnimating()) return;
    setState(() {
      _dragOffset = _offsets[_corner]!;
      _isDragging = true;
    });
  }
}
