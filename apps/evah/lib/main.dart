import 'package:evah/core/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:omni_auth/omni_auth.dart';
import 'package:omni_core/omni_core.dart' show GlobalParamsModel, OmniCore;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final GlobalParamsModel globalParams = GlobalParamsModel(
    theme: theme,
    title: 'OmniSaúde',
    authModule: AuthModule(),
  );
  final OmniCore omniCore = OmniCore(globalParams: globalParams);

  return omniCore.initializeApp();
}
