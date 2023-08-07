import 'package:flutter_triple/flutter_triple.dart';

class SelectWidgetStateStore extends NotifierStore<Exception, bool> {
  SelectWidgetStateStore() : super(false);

  void updateState(bool isActive) {
    update(isActive);
  }
}
