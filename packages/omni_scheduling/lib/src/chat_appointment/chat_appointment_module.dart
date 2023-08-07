import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_bot/omni_bot.dart' show UploadFileStore;
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/chat_appointment/chat_appointment_page.dart';
import 'package:omni_scheduling/src/chat_appointment/chat_appointment_repository.dart';
import 'package:omni_scheduling/src/chat_appointment/stores/back_to_call_store.dart';
import 'package:omni_scheduling/src/chat_appointment/stores/chat_appointment_message_store.dart';
import 'package:omni_scheduling/src/chat_appointment/stores/chat_appointment_store.dart';
import 'package:omni_scheduling/src/chat_appointment/stores/chat_appointment_video_call_store.dart';
import 'package:omni_video_call/omni_video_call.dart';

class ChatAppointmentModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => UploadFileStore()),
    Bind.lazySingleton(
      (i) => ChatAppointmentRepository(i.get<DioHttpClientImpl>()),
    ),
    Bind.lazySingleton((i) => ChatAppointmentStore()),
    Bind.lazySingleton((i) => ChatAppointmentMessageStore()),
    Bind.lazySingleton((i) => ChatAppointmentVideoCallStore()),
    Bind.lazySingleton((i) => VideoCallOutComingStore()),
    Bind.lazySingleton((i) => BackToCallStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => ChatAppointmentPage(scheduling: args.data),
    ),
  ];
}
