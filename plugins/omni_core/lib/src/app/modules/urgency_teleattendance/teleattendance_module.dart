import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/terms/terms_repository.dart';
import 'package:omni_core/src/app/modules/urgency_teleattendance/teleattendance_page.dart';
import 'package:omni_general/omni_general.dart';

class TeleattendanceModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => TermsRepository(i.get<DioHttpClientImpl>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => TeleattendancePage(
        moduleName: args.data,
      ),
    )
  ];
}
