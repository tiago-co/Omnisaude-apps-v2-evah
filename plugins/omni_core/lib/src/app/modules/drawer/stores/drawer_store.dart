import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/app_stores/program_store.dart';
import 'package:omni_general/src/stores/user_store.dart';

// ignore: must_be_immutable
class DrawerStore extends NotifierStore<Exception, int> with Disposable {
  final UserStore userStore = Modular.get();
  final ProgramStore programStore = Modular.get();

  DrawerStore() : super(0);

  Timer? _debounce;

  Future<void> onChangeEnv() async {
    update(state + 1);

    if (state <= 6) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
    }

    if (state < 6) {
      _debounce = Timer(const Duration(milliseconds: 1000), () async {
        update(1);
      });
    } else {
      _debounce = Timer(const Duration(milliseconds: 5500), () async {
        update(1);
      });
    }

    if (state > 10) {
      update(1);
    }
  }

  Future<void> onChangeVariables() async {}

  @override
  void dispose() {
    _debounce?.cancel();
  }
}
