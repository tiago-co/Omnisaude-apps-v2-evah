import 'package:flutter/material.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/discount_widget.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/nearest_consultation/nearest_consultation_widget.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/posts_widget.dart';

import 'widgets/bottom_navigation_bar_widget.dart';
import 'widgets/header.dart';
import 'widgets/reminders/reminders_widget.dart';
import 'widgets/self_assessment/self_assessment_widget.dart';
import 'widgets/services/services_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(),
      body: SafeArea(
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
                  child: const RemindersWidget(),
                ),
                const NearestConsultationWidget(),
                const SelfAssessmentWidget(),
                const PostsWidgets()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
