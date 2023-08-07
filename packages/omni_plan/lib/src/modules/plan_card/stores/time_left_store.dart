import 'package:flutter_triple/flutter_triple.dart';

class TimeLeftStore extends NotifierStore<Exception, double> {
  TimeLeftStore() : super(0);

  void updateTimer(double percent) {
    update(percent);
  }
}
