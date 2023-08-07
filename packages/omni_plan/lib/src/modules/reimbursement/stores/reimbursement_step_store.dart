import 'package:flutter_triple/flutter_triple.dart';

class ReimbursementStepStore extends NotifierStore<Exception, int> {
  ReimbursementStepStore() : super(0);

  void updateStep(int step) {
    update(step);
  }
}
