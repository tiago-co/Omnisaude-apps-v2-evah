import 'package:flutter/material.dart';

class ReminderItem extends StatelessWidget {
  const ReminderItem({required this.appointmentId, required this.title, required this.time});
  final String appointmentId;
  final String title;
  final DateTime time;
  @override
  Widget build(BuildContext context) {
    // double baseWidth = 375;
    // double fem = MediaQuery.of(context).size.width / baseWidth;
    // double ffem = fem * 0.97;
    return Container(
      margin: const EdgeInsets.only(left: 8),
      height: 75,
      constraints: BoxConstraints(minHeight: 75, maxHeight: 95),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        //  BorderRadius.only(
        //   topLeft: buildFullWidget ? Radius.circular(12) : Radius.zero,
        //   topRight: buildFullWidget ? Radius.circular(12) : Radius.zero,
        //   bottomLeft: buildFullWidget ? Radius.zero : Radius.circular(12),
        //   bottomRight: buildFullWidget ? Radius.zero : Radius.circular(12),
        // ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0f1f2023),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: Color(0xffffcccc),
            offset: Offset(-4, 0),
            blurRadius: 0,
          ),
        ],
      ),
      child: Container(
        // component5VGK (I5103:12314;4511:32354)
        height: 75,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffEEEEF2)),
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: Icon(
                    Icons.watch_later_outlined,
                    size: 12,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  // amxZD (I5103:12314;4511:32360)
                  '${time.hour}:${time.minute}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.4000000272,
                    color: Color(0xff878da0),
                  ),
                ),
              ],
            ),
            Text(
              // takethedrugah225VJF (I5103:12314;4511:32361)
              'Tomar "${title}"',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.6,
                color: Color(0xff1a1c22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
