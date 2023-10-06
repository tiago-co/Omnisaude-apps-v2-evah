import 'package:flutter/material.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/self_assessment/self_assessment_item.dart';

class SelfAssessmentWidget extends StatelessWidget {
  const SelfAssessmentWidget();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 20 * fem, 12 * fem),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Auto-avaliação',
                style: TextStyle(
                  fontSize: 22 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 1.2999999306 * ffem / fem,
                  color: Color(0xff1a1c22),
                ),
              ),
              TextButton(
                // buttonprimary35R (4902:28271)
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4 * fem),
                  ),
                  child: Text(
                    'Ver tudo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.5 * ffem / fem,
                      color: Color(0xff52576a),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SelfAssessmentItem()
        ],
      ),
    );
  }
}
