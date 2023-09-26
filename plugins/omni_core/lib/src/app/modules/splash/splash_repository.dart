import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:package_info/package_info.dart';

class SplashRepository extends Disposable {
  Future<bool> verifyAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    final packageName = info.packageName;
    final firebaseVersion = await FirebaseFirestore.instance
        .collection('config')
        .doc('version')
        .get()
      ..data();
    final result = firebaseVersion.data()?.entries.where(
          (element) =>
              element.key == packageName && element.value == info.version,
        );
    return result!.isNotEmpty;
  }

  @override
  void dispose() {}
}
