import 'package:flutter_triple/flutter_triple.dart';

class BottomButtonStore extends NotifierStore<Exception, bool> {
  BottomButtonStore() : super(false);

  void updateButton(bool state) {
    update(state);
  }
}
