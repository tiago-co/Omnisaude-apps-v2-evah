import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_bot/omni_bot.dart';
import 'package:omni_scheduling/src/chat_appointment/chat_appointment_repository.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';

// ignore: must_be_immutable
class ChatAppointmentMessageStore
    extends NotifierStore<Exception, List<BotMessageModel>> with Disposable {
  ChatAppointmentMessageStore()
      : super(List.generate(1, (index) => BotMessageModel()));

  final OmniBotConnection connection = OmniBotConnection();
  StreamSubscription? _messagesSubscription;
  String? avatarUrl;
  String? username;
  final ChatAppointmentRepository repository = Modular.get();

  Future<void> listenMessages(SchedulingModel scheduling) async {
    connection.peer = scheduling.peerBeneficiary!;
    connection.connectionStatus = ConnectionStatus.waiting;
    _messagesSubscription = FirebaseFirestore.instance
        .collection('chat-appointments')
        .doc(scheduling.appointment?.id)
        .collection('messages')
        .orderBy('datetime', descending: true)
        .snapshots()
        .listen(
      (message) {
        connection.connectionStatus = ConnectionStatus.active;
        _messagesSubscription!.pause();
        final List<BotMessageModel> messages =
            message.docs.map((incomingMessage) {
          final BotMessageModel message = BotMessageModel.fromJson(
            incomingMessage.data(),
          );
          message.avatarUrl ??= scheduling.professional?.image;
          return message;
        }).toList();
        if (messages.isNotEmpty) {
          update(messages);
        } else {
          update(List.from(state));
        }
        _messagesSubscription!.resume();
      },
      onError: (handleError) {
        connection.connectionStatus = ConnectionStatus.error;
        setError(Exception(handleError));
        connection.dispose();
      },
      onDone: () {
        connection.connectionStatus = ConnectionStatus.done;
        setError(Exception(connection.connectionStatus));
        connection.dispose();
      },
      cancelOnError: true,
    );
  }

  Future<void> onSendMessage(
    BotMessageModel message,
    SchedulingModel scheduling,
  ) async {
    if (message.message!.value!.trim().isNotEmpty) {
      final DocumentReference documentReference = FirebaseFirestore.instance
          .collection('chat-appointments')
          .doc(scheduling.appointment?.id)
          .collection('messages')
          .doc();

      await FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          transaction.set(
            documentReference,
            BotMessageModel(
              peer: scheduling.peerBeneficiary,
              datetimeFieldValue: FieldValue.serverTimestamp(),
              username: username,
              name: message.name,
              avatarUrl: avatarUrl,
              message: MessageModel(
                messageType: MessageType.text,
                value: message.message!.value!.trim(),
              ),
            ).toJson(),
          );
        },
      );
    }
  }

  Future<void> onUploadFile(
    BotMessageModel message,
    SchedulingModel scheduling,
  ) async {
    setLoading(true);
    final Reference reference = FirebaseStorage.instanceFor()
        .ref()
        .child('chat-appointments')
        .child(scheduling.appointment!.id!)
        .child(message.file!.name!);

    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('chat-appointments')
        .doc(scheduling.appointment!.id)
        .collection('messages')
        .doc();

    await uploadFile(message.file!.value!).then(
      (value) {
        FirebaseFirestore.instance.runTransaction(
          (transaction) async {
            transaction.set(
              documentReference,
              BotMessageModel(
                peer: scheduling.peerBeneficiary,
                datetimeFieldValue: FieldValue.serverTimestamp(),
                username: username,
                avatarUrl: avatarUrl,
                file: FileModel(
                  name: message.file!.name,
                  comment: message.file!.comment,
                  fileType: message.file!.fileType,
                  value: value,
                ),
              ).toJson(),
            );
          },
        );
        setLoading(false);
      },
    ).catchError((onError) {
      log('Firebase Storage Error $onError');
      setLoading(false);
    });
  }

  Future<String> uploadFile(String file) async {
    return repository.uploadFile(file);
}

  @override
  void dispose() {
    _messagesSubscription!.cancel();
    update(List.generate(1, (index) => BotMessageModel()));
  }
}
