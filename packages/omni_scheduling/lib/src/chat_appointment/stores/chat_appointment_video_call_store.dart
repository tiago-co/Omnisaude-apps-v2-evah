import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_bot/omni_bot.dart' show ConnectionStatus;
import 'package:omni_scheduling/src/chat_appointment/stores/back_to_call_store.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';
import 'package:omni_video_call/omni_video_call.dart';
import 'package:omni_video_call/src/video_call/stores/views_controller_store.dart';

// ignore: must_be_immutable
class ChatAppointmentVideoCallStore extends NotifierStore<Exception, bool>
    with Disposable {
  ChatAppointmentVideoCallStore() : super(false);

  StreamSubscription? _videoCallSubscription;
  String docId = '';
  String? token;
  final VideoCallStore videoCallStore = Modular.get();
  final BackToCallStore backToCallStore = Modular.get();
  late final RtcEngine _engine;
  final ViewsControllerStore viewsControllerStore = ViewsControllerStore();

  Future<void> listenVideoCalls(SchedulingModel scheduling) async {
    final String appId = dotenv.env['AGORA_APP_ID']!;

    _engine = await RtcEngine.createWithContext(RtcEngineContext(appId))
        .then((engine) async {
      await engine.enableVideo();
      await engine.startPreview();
      await engine.registerMediaMetadataObserver();
      setLoading(false);
      return engine;
    }).catchError((onError) {
      log('onError: $onError');
      setLoading(false);
      setError(Exception(onError));
    });
    _videoCallSubscription = FirebaseFirestore.instance
        .collection('chat-appointments')
        .doc(scheduling.appointment?.id)
        .collection('calls')
        .orderBy('called_at', descending: true)
        .limit(1)
        .snapshots()
        .listen(
      (event) async {
        _videoCallSubscription!.pause();

        if (event.docs.isEmpty) {
          _videoCallSubscription!.resume();
          return;
        }
        final VideoCallModel videoCall = VideoCallModel.fromJson(
          event.docs.first.data(),
        );
        token = videoCall.token ?? '';
        if (videoCall.finishedBy == null) {
          docId = event.docs.first.id;
          backToCallStore.update(true);
          update(true);
        } else {
          videoCallStore.update(false);
          backToCallStore.update(false);

          _engine.leaveChannel().catchError((onError) {
            log(onError.toString());
          });
          update(false);
        }

        _videoCallSubscription!.resume();
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
    _videoCallSubscription!.cancel();
  }
}
