import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/omni_scheduling.dart';
import 'package:omni_scheduling/src/chat_appointment/chat_appointment_module.dart';
import 'package:omni_scheduling/src/scheduling_details/pages/hilab_exams_page.dart';
import 'package:omni_scheduling/src/scheduling_details/pages/medical_certificate_page.dart';
import 'package:omni_scheduling/src/scheduling_details/pages/medical_records_page.dart';
import 'package:omni_scheduling/src/scheduling_details/pages/prescription_page.dart';
import 'package:omni_scheduling/src/scheduling_details/pages/report_page.dart';
import 'package:omni_scheduling/src/scheduling_details/scheduling_details_page.dart';
import 'package:omni_scheduling/src/scheduling_details/scheduling_details_repository.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/dynamic_medical_records_store.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/medical_certificate_store.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/medical_records_store.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/prescription_store.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/scheduling_details_cancel_store.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/scheduling_details_change_date_store.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/scheduling_details_store.dart';
import 'package:omni_scheduling/src/shared/stores/scheduling_date_store.dart';
import 'package:omni_scheduling/src/shared/stores/scheduling_hour_store.dart';

class SchedulingDetailsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => PrescriptionStore()),
    Bind.lazySingleton((i) => MedicalRecordsStore()),
    Bind.lazySingleton((i) => SchedulingDateStore()),
    Bind.lazySingleton((i) => SchedulingHourStore()),
    Bind.lazySingleton((i) => SchedulingDetailsStore()),
    Bind.lazySingleton((i) => ProfessionalStatusStore()),
    Bind.lazySingleton((i) => MedicalCertificateStore()),
    Bind.lazySingleton((i) => DynamicMedicalRecordsStore()),
    Bind.lazySingleton((i) => SchedulingDetailsCancelStore()),
    Bind.lazySingleton((i) => SchedulingDetailsChangeDateStore()),
    Bind.lazySingleton((i) => SchedulingDetailsBeneficiaryStore()),
    Bind.lazySingleton(
      (i) => SchedulingDetailsRepository(i.get<DioHttpClientImpl>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => SchedulingDetailsPage(
        attendanceType: args.data!['attendanceType'] ?? '-',
        schedulingId: args.data!['schedulingId'],
        beneficiaryId: args.data['beneficiaryId'],
      ),
    ),
    ChildRoute(
      '/medicalCertificate',
      child: (_, args) => MedicalCertificatePage(code: args.data),
    ),
    ChildRoute(
      '/prescription',
      child: (_, args) => PrescriptionPage(prescriptionId: args.data),
    ),
    ChildRoute(
      '/medicalRecords',
      child: (_, args) => MedicalRecordsPage(appointment: args.data),
    ),
    ChildRoute(
      '/hilabExams',
      child: (_, args) => HilabExamsPage(hilabExams: args.data),
    ),
    ChildRoute(
      '/reportPage',
      child: (context, args) => ReportPage(
        service: args.data['service'],
        url: args.data['url'],
        imageArchive: args.data['imageArchive'],
        pdfViewStore: args.data['pdfViewStore'],
      ),
    ),
    ModuleRoute(
      '/chatAppointment',
      module: ChatAppointmentModule(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
