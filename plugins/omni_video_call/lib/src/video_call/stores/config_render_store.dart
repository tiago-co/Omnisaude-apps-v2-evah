import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_video_call/src/core/enums/camera_type_enum.dart';

// ignore: must_be_immutable
class ConfigRenderStore extends NotifierStore<Exception, Alignment> {
  ConfigRenderStore() : super(Alignment.topRight);

  bool fullScreen = false;
  bool pipMode = false;
  bool audioEnabled = true;
  bool videoEnabled = true;

  CameraType cameraType = CameraType.front;

  void forceUpdate() {
    setLoading(true);
    setLoading(false);
  }

  void changePIPMode(bool isEnabled) {
    setLoading(true);
    pipMode = isEnabled;
    final Alignment newState = state;
    update(newState, force: true);
    setLoading(false);
  }

  void changeFullScreen() {
    setLoading(true);
    fullScreen = !fullScreen;
    if (fullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    } else {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
    }
    setLoading(false);
  }

  void updateAlignment(Offset offset, Size size) {
    if (offset.dx >= size.width * 0.5) {
      if (offset.dy >= size.height * 0.5) {
        update(Alignment.bottomRight);
      } else {
        update(Alignment.topRight);
      }
    } else {
      if (offset.dy >= size.height * 0.5) {
        update(Alignment.bottomLeft);
      } else {
        update(Alignment.topLeft);
      }
    }
  }
}
