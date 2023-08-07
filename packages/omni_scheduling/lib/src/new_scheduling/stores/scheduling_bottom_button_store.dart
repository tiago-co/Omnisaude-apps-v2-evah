import 'package:flutter_triple/flutter_triple.dart';

class SchedulingBottomButtonStore extends NotifierStore<Exception, bool> {
  SchedulingBottomButtonStore() : super(true);

  void updateButton(bool state) {
    update(state);
  }
}
