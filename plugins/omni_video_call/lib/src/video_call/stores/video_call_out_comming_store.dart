import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_video_call/src/video_call/stores/video_call_store.dart';

class VideoCallOutComingStore extends NotifierStore<Exception, bool> {
  final VideoCallStore videoCallStore = Modular.get();
  // final ChatAppointmentVideoCallStore chatAppointmentVideoCallStore =
  //     Modular.get();

  VideoCallOutComingStore() : super(false);

  void acceptCall(
    String peerBeneficiary,
    String channelName,
    String token,
  ) {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(
        videoCallStore.documentReference!,
        {
          'accepted_at': FieldValue.serverTimestamp(),
          'accepted_by': peerBeneficiary,
        },
      );
    }).then((value) async {
      await videoCallStore.joinChannel(channelName, token);
      update(true);
      videoCallStore.callDurationStore.initCallDuration();
      videoCallStore.update(true);
    });
  }

  void declineCall(String peerBeneficiary) {
    FirebaseFirestore.instance.runTransaction(
      (transaction) async {
        transaction.update(
          videoCallStore.documentReference!,
          {
            'rejected_at': FieldValue.serverTimestamp(),
            'rejected_by': peerBeneficiary,
            'finished_at': FieldValue.serverTimestamp(),
            'finished_by': peerBeneficiary,
          },
        );
      },
    ).then(
      (value) {
        update(true);
        videoCallStore.update(false);
      },
    );
  }
}
