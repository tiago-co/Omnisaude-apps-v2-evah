import 'package:flutter/material.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/widgets/reminders/reminder_item.dart';

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
            // group43JQo (4511:32349)
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 12 * fem),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4 * fem),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // todaysremindersDGs (4511:32350)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
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
                  // masterbuttonmasterKqh (4902:28304)
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    height: 24 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4 * fem),
                    ),
                    child: Container(
                      // autogroupsseoamd (MYo38CdjnHeUCZMaqbsseo)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 0 * fem),

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
          Container(
            // frame1560eWb (4511:32352)
            width: 335 * fem,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ReminderItem(),
                const ReminderItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
