import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:omni_core/src/app/core/enums/notification_enum.dart';

class UnreadNotificationsCountStore extends NotifierStore<Exception, int> {
  UnreadNotificationsCountStore() : super(0);

  Future<void> getUnreadNotificationsCount(String userId) async {
    setLoading(true);
    FirebaseFirestore.instance
        .collection('notificacoes-v2')
        .doc(userId)
        .collection('notificacoes')
        .where('visualizado', isEqualTo: false)
        .where('tipo', isEqualTo: NotificationType.normal.toJson)
        .orderBy('criado_em', descending: true)
        .snapshots()
        .listen(
      (obj) async {
        if (obj.docs.isNotEmpty) {
          update(obj.docs.length, force: true);
        }

        setLoading(false);
      },
      onError: (handleError) {
        setLoading(false);
        setError(Exception(handleError));
      },
      onDone: () {
        setLoading(false);
      },
      cancelOnError: true,
    );
  }
}
