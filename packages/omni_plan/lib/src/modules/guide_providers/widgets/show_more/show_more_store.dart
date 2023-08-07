import 'package:flutter_triple/flutter_triple.dart';

class ShowMoreStore extends NotifierStore<Exception, bool> {
  ShowMoreStore() : super(false);

  void updateState(bool state) {
    update(state);
  }
}
