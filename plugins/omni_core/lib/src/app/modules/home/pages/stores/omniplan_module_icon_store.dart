import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/home_store.dart';
import 'package:omni_general/omni_general.dart';

class OmniplanModuleIconStore extends NotifierStore<Exception, bool> {
  OmniplanModuleIconStore() : super(false);

  final HomeStore store = Modular.get();

  void getOmniPlanModuleStatus() {
    update(false);
    setLoading(true);
    store.modulesStore.state.forEach(
      (element) {
        if (element.type == ModuleType.planCard) {
          update(true);
        }
      },
    );
    setLoading(false);
  }
}
