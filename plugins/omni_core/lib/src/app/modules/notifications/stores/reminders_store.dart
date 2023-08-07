import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/notification_enum.dart';
import 'package:omni_core/src/app/modules/notifications/stores/notices_store.dart';

// ignore: must_be_immutable
class ReminderStore extends NotifierStore<Exception,
    List<QueryDocumentSnapshot<Map<String, dynamic>>>> with Disposable {
  final NoticesStore noticesStore = Modular.get();

  ReminderStore()
      : super(
          List<QueryDocumentSnapshot<Map<String, dynamic>>>.empty(
            growable: true,
          ),
        );

  late StreamSubscription _notificationSubscription;

  Future<void> listenReminder(String userId) async {
    setLoading(true);
    _notificationSubscription = FirebaseFirestore.instance
        .collection('notificacoes-v2')
        .doc(userId)
        .collection('notificacoes')
        .where('removido', isEqualTo: false)
        .where('tipo', isEqualTo: NotificationType.reminder.toJson)
        .orderBy('criado_em', descending: true)
        .snapshots()
        .listen(
      (obj) async {
        _notificationSubscription.pause();
        if (obj.docs.isNotEmpty) {
          update(List.from(obj.docs), force: true);
        } else {
          update(List.from(state), force: true);
        }
        _notificationSubscription.resume();
        setLoading(false);
      },
      onError: (handleError) {
        setLoading(false);
        setError(Exception(handleError));
        log('$handleError');
      },
      onDone: () {
        setLoading(false);
      },
      cancelOnError: true,
    );
  }

  @override
  void dispose() {
    _notificationSubscription.cancel();
  }
}
