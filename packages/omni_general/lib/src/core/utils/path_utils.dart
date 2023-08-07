import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class PathUtils {
  Future<String> get localPath async {
    await Permission.mediaLibrary.request();
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> get tempPath async {
    await Permission.mediaLibrary.request();
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  Future<File?> getFileFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final file = File('${await localPath}/$path');
      file.writeAsBytesSync(
        byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );
      return file;
    } catch (e) {
      log('getFileFromAssets: $e');
      rethrow;
    }
  }

  Future<File?> getFileFromUrl(String url) async {
    try {
      final HttpClientRequest request = await HttpClient().getUrl(
        Uri.parse(url),
      );
      final HttpClientResponse response = await request.close();
      final Uint8List bytes = await consolidateHttpClientResponseBytes(
        response,
      );
      final String ext = url.split('.').last;
      final String name = const Uuid().v1();
      final File file = File('${await localPath}/$name.$ext');
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      log('getFileFromUrl: $e');
      rethrow;
    }
  }
}
