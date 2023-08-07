import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

class TeleattendanceStore extends NotifierStore<DioError, bool> {
  TeleattendanceStore() : super(false);
}
