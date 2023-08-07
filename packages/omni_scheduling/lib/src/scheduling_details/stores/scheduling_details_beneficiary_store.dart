import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';

class SchedulingDetailsBeneficiaryStore extends NotifierStore<Exception, bool> {
  SchedulingDetailsBeneficiaryStore() : super(false);

  Future<void> setBeneficiaryIntoStatus(SchedulingModel scheduling) async {
    final DocumentReference reference = FirebaseFirestore.instance
        .collection('chat-appointments')
        .doc(scheduling.appointment?.id);
    FirebaseFirestore.instance.runTransaction(
      (transaction) async {
        transaction.update(reference, {
          'beneficiario_online': true,
          'beneficiario_entrou': true,
        });
      },
    );
  }

  Future<void> setBeneficiaryExitStatus(SchedulingModel scheduling) async {
    final DocumentReference reference = FirebaseFirestore.instance
        .collection('chat-appointments')
        .doc(scheduling.appointment?.id);
    FirebaseFirestore.instance.runTransaction(
      (transaction) async {
        transaction.update(reference, {'beneficiario_online': false});
      },
    );
  }
}
