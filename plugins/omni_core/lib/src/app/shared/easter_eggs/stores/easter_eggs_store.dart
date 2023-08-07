import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/env_enum.dart';
import 'package:omni_general/omni_general.dart';

// ignore: must_be_immutable
class EasterEggsStore extends NotifierStore<Exception, EnvType>
    with Disposable {
  final UserStore userStore = Modular.get();
  EnvType? environmentType;
  final BaseUrlStore baseUrlStore = Modular.get();
  EasterEggsStore() : super(EnvType.prod);

  Future<void> onChangeEnv(EnvType env) async {
    setLoading(true);
    environmentType = env;
    final String baseURL = dotenv.env['BASE_URL']! + dotenv.env['API']!;
    switch (env) {
      case EnvType.prod:
        dotenv.env['BASE_URL'] = dotenv.env['PROD_BASE_URL']!;
        baseUrlStore.changeToProd();
        break;
      case EnvType.homol:
        dotenv.env['BASE_URL'] = dotenv.env['HOMOL_BASE_URL']!;
        baseUrlStore.changeToHomol();
        break;
      case EnvType.demo:
        dotenv.env['BASE_URL'] = dotenv.env['DEMO_BASE_URL']!;
        baseUrlStore.changeToDemo();
        break;
      // case EnvType.impl:
      //   dotenv.env['BASE_URL'] = dotenv.env['IMPL_BASE_URL']!;
      //   baseUrlStore.changeToImpl();
      //   break;
    }
    final Dio dio = Modular.get<Dio>();
    dio.options.baseUrl = dotenv.env['BASE_URL']! + dotenv.env['API']!;
    await userStore.getOperatorConfigs().then((oprConfigs) async {
      setLoading(false);
    }).catchError((onError) {
      dio.options.baseUrl = baseURL;
      setLoading(false);
      throw onError;
    });
  }

  void checkEnvType() {
    if (dotenv.env['BASE_URL']!.contains('demo')) {
      environmentType = EnvType.demo;
    } else if (dotenv.env['BASE_URL']!.contains('homol')) {
      environmentType = EnvType.homol;
    } else {
      environmentType = EnvType.prod;
    }
  }

  @override
  void dispose() {}
}
