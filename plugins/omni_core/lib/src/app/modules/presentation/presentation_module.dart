import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/onboarding/onboarding.dart';

import 'package:omni_core/src/app/modules/presentation/pages/presentation_page.dart';
import 'package:omni_core/src/app/modules/presentation/pages/slider_presentation_page.dart';

class PresentationModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => Onboarding(),
      // child: (_, args) => SliderPresentationPage(),
    ),
    ChildRoute(
      '/letsGo',
      child: (_, args) => const PresentationPage(),
    ),
  ];
}
