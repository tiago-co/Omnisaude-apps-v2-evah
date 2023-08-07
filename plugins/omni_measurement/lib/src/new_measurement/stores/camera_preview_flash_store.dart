import 'package:camera/camera.dart';
import 'package:flutter_triple/flutter_triple.dart';

class CameraPreviewFlashStore extends NotifierStore<Exception, FlashMode> {
  CameraPreviewFlashStore() : super(FlashMode.off);

  void updateFlash(FlashMode state) {
    setLoading(true);
    update(state);
    setLoading(false);
  }
}
