import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static PermissionStatus status = PermissionStatus.denied;

  static Future<PermissionStatus> camera() async {
    return Permission.camera.request();
  }

  static Future<PermissionStatus> cameraStatus() async {
    return Permission.camera.status;
  }

  static Future<PermissionStatus> microphone() async {
    return Permission.microphone.request();
  }

  static Future<PermissionStatus> microphoneStatus() async {
    return Permission.microphone.status;
  }

  static Future<bool> locationAlwaysIsGranted() async {
    return Permission.locationAlways.status.isGranted;
  }

  static Future<bool> locationWhenInUseStatus() async {
    return Permission.locationWhenInUse.status.isGranted;
  }

  static Future<void> notification() async {
    await FirebaseMessaging.instance.requestPermission(
      provisional: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );
  }

  static Future<bool> locationAlways() async {
    return Permission.locationAlways.request().isGranted;
  }

  static Future<bool> locationWhenInUse() async {
    return Permission.locationWhenInUse.request().isGranted;
  }

  static Future<bool> openSettings() async {
    return openAppSettings();
  }

  static Future<bool> bluetoothScan() async {
    return Permission.bluetoothScan.request().isGranted;
  }

  static Future<bool> bluetoothConnect() async {
    return Permission.bluetoothConnect.request().isGranted;
  }

  static Future<bool> getLocations() async {
    final locationWhenInUseStatus =
        await Permission.locationWhenInUse.request();
    final locationAlways = await Permission.locationAlways.request();

    return locationWhenInUseStatus.isGranted || locationAlways.isGranted;
  }
}
