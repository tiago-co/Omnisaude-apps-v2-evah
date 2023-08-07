import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/omni_scheduling.dart';
import 'package:omni_video_call/src/core/enums/camera_type_enum.dart';
import 'package:omni_video_call/src/core/models/remote_uid_model.dart';
import 'package:omni_video_call/src/video_call/stores/call_duration_store.dart';
import 'package:omni_video_call/src/video_call/stores/call_permission_store.dart';
import 'package:omni_video_call/src/video_call/stores/config_render_store.dart';
import 'package:omni_video_call/src/video_call/stores/views_controller_store.dart';

// ignore: must_be_immutable
class VideoCallStore extends NotifierStore<Exception, bool> with Disposable {
  VideoCallStore() : super(false);

  final CallPermissionStore permissionStore = CallPermissionStore();
  final CallDurationStore callDurationStore = CallDurationStore();
  late ChatAppointmentVideoCallStore chatCallStore;
  final ConfigRenderStore configStore = ConfigRenderStore();
  final ViewsControllerStore viewsControllerStore = ViewsControllerStore();
  final List<RemoteUidModel> remoteUid = List.empty(growable: true);
  late RtcEngine _engine;
  late DocumentReference? documentReference;

  Future<void> initEngine(BuildContext context) async {
    chatCallStore = Modular.get();
    setLoading(true);
    final String appId = dotenv.env['AGORA_APP_ID']!;

    _engine = await RtcEngine.createWithContext(RtcEngineContext(appId))
        .then((engine) async {
      await engine.enableVideo();
      await engine.startPreview();
      await engine.registerMediaMetadataObserver();
      viewsControllerStore.updateViewsAmount(remoteUid.length);
      setLoading(false);
      return engine;
    }).catchError((onError) {
      log('onError: $onError');
      setLoading(false);
      setError(Exception(onError));
      throw onError;
    });
    _addListeners();
  }

  Future<void> joinChannel(
    String channelName,
    String token,
  ) async {
    await _engine.joinChannel(
      token,
      channelName,
      'optionalInfo',
      channelName.hashCode,
    );
  }

  void _addListeners() {
    _engine.setEventHandler(
      RtcEngineEventHandler(
        error: (err) {
          log('Agora Error: $err');
        },
        joinChannelSuccess: (channel, uid, elapsed) {
          log('joinChannelSuccess $channel $uid $elapsed');
        },
        leaveChannel: (stats) async {
          log('leaveChannel ${stats.toJson()}');
          setLoading(true, force: true);
          remoteUid.clear();
          viewsControllerStore.updateViewsAmount(remoteUid.length);
        },
        metadataReceived: (metadata) {
          log('metadataReceived $metadata');
        },
        userJoined: (uid, elapsed) {
          log('userJoined  $uid $elapsed');
          setLoading(true);

          final RemoteUidModel model = RemoteUidModel(
            uid: uid,
            audioDisabled: false,
            videoDisabbled: false,
          );

          remoteUid.add(model);

          viewsControllerStore.updateViewsAmount(remoteUid.length);
          setLoading(false);
          configStore.setLoading(true);
          configStore.setLoading(false);
        },
        apiCallExecuted: (error, api, result) {
          log('API Executed $error, $api, $result');
        },
        userMuteAudio: (uid, muted) {
          setLoading(true);
          remoteUid.forEach(
            (element) {
              if (element.uid == uid) {
                element.audioDisabled = muted;
              }
            },
          );
          setLoading(false);
          configStore.setLoading(true);
          configStore.setLoading(false);
        },
        userMuteVideo: (uid, muted) {
          setLoading(true);
          remoteUid.forEach(
            (element) {
              if (element.uid == uid) {
                element.videoDisabbled = muted;
              }
            },
          );
          setLoading(false);
          configStore.setLoading(true);
          configStore.setLoading(false);
        },
        userOffline: (uid, reason) async {
          log('userOffline  $uid $reason');
          setLoading(true);
          remoteUid.removeWhere((element) => element.uid == uid);
          viewsControllerStore.updateViewsAmount(remoteUid.length);
          setLoading(false);
          configStore.setLoading(true);
          configStore.setLoading(false);
        },
      ),
    );
  }

  // Future<void> callFinishedByProfessional() async {
  //   await _engine.leaveChannel().catchError((onError) {
  //     log(onError.toString());
  //   });

  //   chatCallStore.update(false);

  //   update(false);
  //   callDurationStore.finishCallDuration();
  // }

  Future<void> finishCall(String peerBeneficiary) async {
    // await FirebaseFirestore.instance.runTransaction((transaction) async {
    //   transaction.update(
    //     documentReference!,
    //     {
    //       'finished_at': FieldValue.serverTimestamp(),
    //       'finished_by': peerBeneficiary,
    //     },
    //   );
    // });
    await _engine.leaveChannel().catchError((onError) {
      log(onError.toString());
    });

    chatCallStore.update(false);

    update(false);
    callDurationStore.finishCallDuration();
  }

  void initDocumentReference(String docId, String appointmentId) {
    documentReference = FirebaseFirestore.instance
        .collection('chat-appointments')
        .doc(appointmentId)
        .collection('calls')
        .doc(docId);
  }

  Future<void> switchCamera() async {
    await _engine.switchCamera();
    configStore.setLoading(true);
    switch (configStore.cameraType) {
      case CameraType.front:
        configStore.cameraType = CameraType.back;
        break;
      case CameraType.back:
        configStore.cameraType = CameraType.front;
        break;
    }
    configStore.setLoading(false);
  }

  Future<void> enableLocalAudio(bool value) async {
    await _engine.enableLocalAudio(value);
    configStore.setLoading(true);
    configStore.audioEnabled = value;
    configStore.setLoading(false);
  }

  Future<void> enableLocalVideo(bool value) async {
    await _engine.enableLocalVideo(value);
    configStore.setLoading(true);
    configStore.videoEnabled = value;
    configStore.setLoading(false);
  }

  @override
  void dispose() {
    configStore.destroy();
    permissionStore.destroy();
    callDurationStore.destroy();
  }
}
