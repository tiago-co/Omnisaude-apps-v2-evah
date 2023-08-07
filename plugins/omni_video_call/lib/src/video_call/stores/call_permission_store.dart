import 'dart:async';

import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart' show Permissions;
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class CallPermissionStore extends NotifierStore<Exception, PermissionStatus> {
  CallPermissionStore() : super(PermissionStatus.restricted);

  PermissionStatus cameraStatus = PermissionStatus.restricted;
  PermissionStatus microphoneStatus = PermissionStatus.restricted;

  Future<void> getCallPermissionsStatus() async {
    setLoading(true);
    cameraStatus = await Permissions.cameraStatus();
    microphoneStatus = await Permissions.microphoneStatus();
    setLoading(false);
  }

  Future<void> getCameraPermission() async {
    setLoading(true);
    await Permissions.camera().then((status) {
      cameraStatus = status;
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(Exception());
    });
  }

  Future<void> getMicrophonePermission() async {
    setLoading(true);
    await Permissions.microphone().then((status) {
      microphoneStatus = status;
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(Exception());
    });
  }

  Future<void> openSettings() async {
    setLoading(true);
    await Permissions.openSettings().then((status) {
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(Exception());
    });
  }

  Future<void> requestPermissions() async {
    setLoading(true);
    getCallPermissionsStatus().then((_) {
      if (cameraStatus != PermissionStatus.granted) {
        getCameraPermission();
      }
      if (microphoneStatus != PermissionStatus.granted) {
        getMicrophonePermission();
      }
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(Exception());
    });
  }
}
