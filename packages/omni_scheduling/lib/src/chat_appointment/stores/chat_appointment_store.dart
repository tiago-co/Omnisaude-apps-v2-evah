import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_bot/omni_bot.dart';
import 'package:omni_scheduling/src/chat_appointment/stores/chat_appointment_message_store.dart';
import 'package:omni_scheduling/src/chat_appointment/stores/chat_appointment_video_call_store.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/scheduling_details_beneficiary_store.dart';
import 'package:omni_scheduling/src/shared/stores/professional_status_store.dart';

class ChatAppointmentStore
    extends NotifierStore<Exception, List<BotMessageModel>> with Disposable {
  final ChatAppointmentMessageStore messageStore = Modular.get();
  final ChatAppointmentVideoCallStore videoCallStore = Modular.get();
  final ProfessionalStatusStore professionalStatusStore = Modular.get();
  final SchedulingDetailsBeneficiaryStore beneficiaryStore = Modular.get();

  ChatAppointmentStore()
      : super(List.generate(1, (index) => BotMessageModel()));

  @override
  void dispose() {
    messageStore.dispose();
    videoCallStore.dispose();
  }
}
