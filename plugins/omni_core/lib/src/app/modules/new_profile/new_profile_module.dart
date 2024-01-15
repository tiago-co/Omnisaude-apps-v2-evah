import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_assistance/omni_assistance.dart';
import 'package:omni_core/src/app/modules/new_diagnosis/diagnosis_page.dart';
import 'package:omni_core/src/app/modules/new_profile/profile_edit_page.dart';
import 'package:omni_core/src/app/modules/new_profile/profile_page.dart';
import 'package:omni_core/src/app/modules/new_profile/settings/settings_page.dart';
import 'package:omni_core/src/app/modules/new_settings/new_settings_module.dart';
import 'package:omni_core/src/app/modules/profile/profile_store.dart';
import 'package:omni_core/src/app/modules/terms/terms_module.dart';
import 'package:omni_general/omni_general.dart';

// import 'package:omni_core/src/app/modules/profile/profile_store.dart';
// import 'package:omni_general/omni_general.dart';

class NewProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => ProfileStore()),
    Bind.lazySingleton((i) => ZipCodeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => ProfilePage()),
    ChildRoute('/editProfile', child: (_, args) => ProfileEditPage()),
    ChildRoute('/diagnosis', child: (_, args) => DiagnosisPage()),
    ModuleRoute(
      '/terms',
      module: TermsModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute('/assistance', module: AssistanceModule()),
    ModuleRoute(
      '/settings',
      module: NewSettingsModule(),
      transition: TransitionType.fadeIn,
    )
  ];
}
