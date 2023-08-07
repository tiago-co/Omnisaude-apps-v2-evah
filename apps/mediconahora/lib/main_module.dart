import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/omni_auth.dart';
import 'package:omni_general/omni_general.dart' show AuthInterceptor;

class MainModule extends Module {
  // final String poweredBy = 'profarma.omnisaude.co';

  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => Dio(
        BaseOptions(
          baseUrl: dotenv.env['BASE_URL']! + dotenv.env['API']!,
          connectTimeout: int.parse(dotenv.env['TIMEOUT']!),
          headers: {'X-Powered-By': dotenv.env['POWERED_BY']},
        ),
      )..interceptors.addAll([
          AuthInterceptor(),
          LogInterceptor(
            responseHeader: false,
            responseBody: true,
            error: false,
          ),
        ]),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      '/auth',
      module: AuthModule(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
