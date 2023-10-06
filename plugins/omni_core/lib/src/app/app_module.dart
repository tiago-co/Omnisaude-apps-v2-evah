import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/app_stores/program_store.dart';
import 'package:omni_core/src/app/app_widget.dart';
import 'package:omni_core/src/app/modules/home/home_module.dart';
import 'package:omni_core/src/app/modules/home/new_home_module.dart';
import 'package:omni_core/src/app/modules/presentation/presentation_module.dart';
import 'package:omni_core/src/app/modules/presentation/stores/slider_presentation_store.dart';
import 'package:omni_core/src/app/modules/splash/splash_module.dart';
import 'package:omni_core/src/app/modules/terms/terms_module.dart';
import 'package:omni_core/src/app/shared/easter_eggs/stores/easter_eggs_store.dart';
import 'package:omni_general/omni_general.dart'
    show
        AuthInterceptor,
        BaseUrlStore,
        BeneficiaryRepository,
        DioHttpClientImpl,
        FirebaseService,
        LecuponRepository,
        AppStateStore,
        ModuleRepository,
        ProgramRepository;

class AppModule extends Module {
  final GlobalParamsModel globalParams;

  AppModule({required this.globalParams}) {
    routes.add(
      ModuleRoute(
        '/auth',
        module: globalParams.authModule,
        transition: TransitionType.fadeIn,
      ),
    );
  }

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
    Bind.lazySingleton((i) => LecuponRepository()),
    Bind.lazySingleton((i) => UserStore()),
    Bind.lazySingleton((i) => AppStateStore()),
    Bind.lazySingleton((i) => ProgramStore()),
    Bind.lazySingleton((i) => BaseUrlStore()),
    Bind.lazySingleton((i) => ModulesStore()),
    Bind.lazySingleton((i) => FirebaseService()),
    Bind.lazySingleton((i) => EasterEggsStore()),
    Bind.lazySingleton((i) => MyNavigatorObserver()),
    Bind.lazySingleton((i) => SliderPresentationStore()),
    Bind.lazySingleton((i) => ModuleRepository(i.get<DioHttpClientImpl>())),
    Bind.lazySingleton((i) => ProgramRepository(i.get<DioHttpClientImpl>())),
    Bind.lazySingleton(
      (i) => BeneficiaryRepository(i.get<DioHttpClientImpl>()),
    ),
    Bind.lazySingleton((i) => DioHttpClientImpl(i.get<Dio>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
    ModuleRoute(
      '/terms',
      module: TermsModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/presentation',
      module: PresentationModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/home',
      module: HomeModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/newHome',
      module: NewHomeModule(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
