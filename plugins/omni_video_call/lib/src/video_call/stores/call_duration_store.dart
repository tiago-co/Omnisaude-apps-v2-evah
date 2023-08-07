import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

// ignore: must_be_immutable
class CallDurationStore extends NotifierStore<Exception, DateTime>
    with Disposable {
  CallDurationStore()
      : super(
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
        );

  late Timer? timer;

  void initCallDuration() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        final DateTime date = DateTime(state.year, state.month, state.day).add(
          Duration(seconds: timer.tick),
        );
        update(date);
      },
    );
  }

  void finishCallDuration() {
    timer?.cancel();
    timer = null;
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
  }
}
