import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/omni_core.dart';

import 'package:omni_core/src/app/app_module.dart';
import 'package:omni_core/src/app/app_widget.dart';

class OmniCore {
  final GlobalParamsModel globalParams;

  OmniCore({required this.globalParams});

  Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    await dotenv.load().catchError(
      (onError) {
        log('Erro ao carregar as variáveis de ambiente: $onError');
      },
    );
    await Firebase.initializeApp();

    return runApp(
      ModularApp(
        module: AppModule(globalParams: globalParams),
        child: AppWidget(
          theme: globalParams.theme,
          title: globalParams.title,
        ),
      ),
    );
  }
}
