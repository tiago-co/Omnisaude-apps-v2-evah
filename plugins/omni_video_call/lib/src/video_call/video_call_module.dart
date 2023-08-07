import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_scheduling/omni_scheduling.dart';

import 'package:omni_video_call/src/video_call/pages/video_call_page.dart';
import 'package:omni_video_call/src/video_call/stores/video_call_store.dart';

class VideoCallModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => VideoCallStore()),
    Bind.lazySingleton((i) => SchedulingDetailsBeneficiaryStore()),
    Bind.lazySingleton((i) => ProfessionalStatusStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => VideoCallPage(
        docId: args.data!['docId'],
        appointmentId: args.data!['appointmentId'],
        peerBeneficiary: args.data!['peerBeneficiary'],
        professionalImage: args.data!['professionalImage'],
        professionalName: args.data!['professionalName'],
        token: args.data!['token'],
        // throughNotification: args.data!['throughNotification'],
      ),
    ),
  ];
}
