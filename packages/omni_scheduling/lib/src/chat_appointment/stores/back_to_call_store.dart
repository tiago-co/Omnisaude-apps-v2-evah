import 'package:flutter_triple/flutter_triple.dart';

class BackToCallStore extends NotifierStore<Exception, bool> {
  BackToCallStore() : super(false);

  void updateState(bool newState) {
    update(newState, force: true);
  }
}
