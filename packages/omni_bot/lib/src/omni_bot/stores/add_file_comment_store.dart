import 'dart:io';

import 'package:flutter_triple/flutter_triple.dart';

class AddFileCommentStore extends NotifierStore<Exception, File> {
  AddFileCommentStore() : super(File(''));
}
