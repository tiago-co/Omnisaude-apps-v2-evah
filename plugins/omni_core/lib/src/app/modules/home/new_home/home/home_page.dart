import 'package:flutter/material.dart';
import 'package:myapp/ui/home/widgets/discount_widget.dart';
import 'package:myapp/ui/home/widgets/nearest_consultation/nearest_consultation_widget.dart';
import 'package:myapp/ui/home/widgets/posts_widget.dart';

import 'widgets/bottom_navigation_bar_widget.dart';
import 'widgets/header.dart';
import 'widgets/reminders/reminders_widget.dart';
import 'widgets/self_assessment/self_assessment_widget.dart';
import 'widgets/services/services_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      bottomNavigationBar: const BottomNavigationBarWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Header(),
                const ServicesWidget(),
                SizedBox(
                  height: 40 * fem,
                ),
                const DiscountsWidget(),
                SizedBox(
                  height: 40 * fem,
                ),
                const RemindersWidget(),
                SizedBox(
                  height: 40 * fem,
                ),
                const NearestConsultationWidget(),
                SizedBox(
                  height: 40 * fem,
                ),
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
