import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/reminders/reminder_item.dart';
import 'package:omni_general/omni_general.dart';

class RemindersWidget extends StatelessWidget {
  const RemindersWidget();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      // frame1503ZCK (4511:32348)

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 12 * fem),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4 * fem),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                  child: Text(
                    'Lembretes de Hoje',
                    style: TextStyle(
                      fontSize: 22 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.2999999306 * ffem / fem,
                      color: Color(0xff1a1c22),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Modular.to.pushNamed('/newHome/drugControl/newDrugControl', arguments: {
                    //   'useCustomMedication': true,
                    //   'useCaregiver': true,
                    //   'moduleName': 'moduleName',
                    //   'program': ProgramModel(code: 'MEDICONAHORA'),
                    // });
                    Modular.to.pushNamed(
                      '/newHome/reminders',
                      arguments: {
                        'moduleName': 'lembretes',
                        'program': ProgramModel(code: 'MEDICONAHORA'),
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    height: 24 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4 * fem),
                    ),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                      height: double.infinity,
                      child: Center(
                        child: Center(
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
                    ),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   width: 335 * fem,
          //   child: const Column(
          //     children: [
          //       ReminderItem(
          //         buildFullWidget: true,
          //       ),
          //       ReminderItem(
          //         buildFullWidget: true,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
