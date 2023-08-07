import 'package:flutter_triple/flutter_triple.dart';
import 'package:package_info/package_info.dart';

class AboutStore extends NotifierStore<Exception, PackageInfo> {
  AboutStore()
      : super(
          PackageInfo(
            appName: 'appName',
            packageName: 'packageName',
            version: 'version',
            buildNumber: 'buildNumber',
          ),
        );

  Future<void> getPackageInfo() async {
    PackageInfo.fromPlatform().then((PackageInfo info) {
      update(info);
    });
  }
}
