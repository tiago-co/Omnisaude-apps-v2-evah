import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_bot/omni_bot.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';

// ignore: must_be_immutable
class ProfessionalStatusStore extends NotifierStore<Exception, bool>
    with Disposable {
  ProfessionalStatusStore() : super(false);

  StreamSubscription? _subscription;

  Future<void> getProfessionalStatus(SchedulingModel scheduling) async {
    _subscription = FirebaseFirestore.instance
        .collection('chat-appointments')
        .doc(scheduling.appointment?.id)
        .snapshots()
        .listen(
      (snapshot) {
        _subscription!.pause();
        if (snapshot.data() == null) {
          _subscription!.resume();
          return;
        }
        final bool? online = snapshot.data()!['profissional_online'];
        update(online ?? false);
        _subscription!.resume();
      },
      onError: (handleError) {
        setError(Exception(handleError));
      },
      onDone: () {
        setError(Exception(ConnectionStatus.done));
      },
      cancelOnError: true,
    );
  }

  @override
  void dispose() {
    _subscription!.cancel();
  }
}
