import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/discount_widget.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/nearest_consultation/nearest_consultation_widget.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/posts_widget.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/home_store.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/omniplan_module_icon_store.dart';
import 'package:omni_core/src/app/modules/new_reminders/stores/drug_control_historic_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_mediktor/omni_mediktor.dart';

import 'bottom_navigation_bar_widget.dart';
import 'header.dart';
import 'reminders/reminders_widget.dart';
import 'self_assessment/self_assessment_widget.dart';
import 'services/services_widget.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent();

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final HomeStore store = Modular.get();
  final OmniplanModuleIconStore omniplanModuleIconStore = Modular.get();
  final MediktorDiagnosisStore mediktorDiagnosisStore = Modular.get();
  @override
  void initState() {
    super.initState();
    store.modulesStore.getActiveModules().then(
      (value) {
        omniplanModuleIconStore.getOmniPlanModuleStatus();
        store.modulesStore.state.any((element) => element.type == ModuleType.mediktor)
            ? mediktorDiagnosisStore.authenticate()
            : null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              Container(
                padding: const EdgeInsets.only(right: 0),
                child: const ServicesWidget(),
              ),
              SizedBox(
                height: 40 * fem,
              ),
              Container(
                padding: const EdgeInsets.only(right: 20),
                child: const DiscountsWidget(),
              ),
              Container(
                padding: const EdgeInsets.only(right: 20),
                child: RemindersWidget(),
              ),
              // const NearestConsultationWidget(),
              // const SelfAssessmentWidget(),
              // const PostsWidgets()
            ],
          ),
        ),
      ),
    );
  }
}
