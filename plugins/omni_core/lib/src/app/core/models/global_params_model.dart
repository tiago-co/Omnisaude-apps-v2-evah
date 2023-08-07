import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GlobalParamsModel {
  final String title;
  final ThemeData theme;
  final Module authModule;

  GlobalParamsModel({
    required this.title,
    required this.theme,
    required this.authModule,
  });
}
