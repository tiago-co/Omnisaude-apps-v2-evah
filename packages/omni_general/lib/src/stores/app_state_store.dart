import 'package:flutter_triple/flutter_triple.dart';

class AppStateStore extends NotifierStore<Exception, bool> {
  AppStateStore() : super(false);

  bool isAppPaused() {
    return state;
  }

  void updateState(bool newState) {
    update(newState);
  }
}
