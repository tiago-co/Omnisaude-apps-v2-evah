import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FirebaseService extends Disposable {
  late final FirebaseMessaging _firebaseMessaging;

  Future<void> setUpFirebase() async {
    await Firebase.initializeApp();
    _firebaseMessaging = FirebaseMessaging.instance;

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> onSubscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic).then((value) {
      log('Inscrito no tópico: $topic');
    }).catchError((onError) {
      log('Erro ao inscrever no tópico: $topic');
    });
  }

  Future<void> onUnsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic).then((value) async {
      await _firebaseMessaging.unsubscribeFromTopic(dotenv.env['POWERED_BY']!);
      log('Desinscrito do tópico: $topic');
    }).catchError((onError) {
      log('Erro ao Desinscrever no tópico: $topic');
    });
  }

  @override
  void dispose() {}
}
