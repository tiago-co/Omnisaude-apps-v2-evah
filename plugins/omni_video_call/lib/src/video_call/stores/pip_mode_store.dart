import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_video_call/src/core/enums/pip_view_corner_enum.dart';
import 'package:omni_video_call/src/video_call/pages/pip_mode_page.dart';

class PipModeStore extends NotifierStore<Exception, Alignment> {
  PipModeStore() : super(Alignment.topLeft);

  PIPViewCorner calculateNearestCorner({
    Offset? offset,
    Map<PIPViewCorner, Offset>? offsets,
  }) {
    CornerDistance calculateDistance(PIPViewCorner corner) {
      final distance =
          offsets![corner]!.translate(-offset!.dx, -offset.dy).distanceSquared;
      return CornerDistance(corner: corner, distance: distance);
    }

    final distances = PIPViewCorner.values.map(calculateDistance).toList();

    distances.sort((cd0, cd1) => cd0.distance!.compareTo(cd1.distance!));

    return distances.first.corner!;
  }

  Map<PIPViewCorner, Offset> calculateOffsets({
    Size? spaceSize,
    Size? widgetSize,
    EdgeInsets? windowPadding,
  }) {
    Offset getOffsetForCorner(PIPViewCorner corner) {
      const spacing = 15;
      final left = spacing + windowPadding!.left;
      final top = spacing + windowPadding.top;
      final right =
          spaceSize!.width - widgetSize!.width - windowPadding.right - spacing;
      final bottom =
          spaceSize.height - widgetSize.height - windowPadding.bottom - spacing;

      switch (corner) {
        case PIPViewCorner.topLeft:
          return Offset(left, top);
        case PIPViewCorner.topRight:
          return Offset(right, top);
        case PIPViewCorner.bottomLeft:
          return Offset(left, bottom);
        case PIPViewCorner.bottomRight:
          return Offset(right, bottom);
        default:
          throw Exception('Not implemented.');
      }
    }

    const corners = PIPViewCorner.values;
    final Map<PIPViewCorner, Offset> offsets = {};
    for (final corner in corners) {
      offsets[corner] = getOffsetForCorner(corner);
    }

    return offsets;
  }
}
