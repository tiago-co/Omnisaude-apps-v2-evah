import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';

class ShareFileService extends Disposable {
  Future<void> file(BuildContext context, File file, {String? filename}) async {
    final String filename0 = filename ?? basename(file.path);
    final RenderBox box = context.findRenderObject()! as RenderBox;
    final XFile xfile = XFile(file.path);
    await Share.shareXFiles(
      [xfile],
      subject: filename0,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  void dispose() {}
}
