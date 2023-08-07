import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_bot/src/omni_bot/omni_bot_page.dart';
import 'package:omni_bot/src/omni_bot/stores/omni_bot_store.dart';
import 'package:omni_bot/src/omni_bot/stores/panel_bottom_store.dart';
import 'package:omni_bot/src/omni_bot/stores/select_store.dart';
import 'package:omni_bot/src/omni_bot/stores/select_widget_state_store.dart';
import 'package:omni_bot/src/omni_bot/stores/upload_file_store.dart';

class OmniBotModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SelectStore()),
    Bind.lazySingleton((i) => OmniBotStore()),
    Bind.lazySingleton((i) => UploadFileStore()),
    Bind.lazySingleton((i) => PanelBottomStore()),
    Bind.factory((i) => SelectWidgetStateStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => OmniBotPage(
        title: args.data!['title'],
        botId: args.data!['botId'],
        jwt: args.data!['jwt'],
        beneficiary: args.data!['beneficiary'],
      ),
    ),
  ];
}
