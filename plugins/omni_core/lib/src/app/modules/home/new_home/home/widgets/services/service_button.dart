import 'package:flutter/material.dart';

class ServiceButton extends StatelessWidget {
  const ServiceButton(
      {required this.image, required this.title, this.inverted = false});
  final Widget image;
  final String title;
  final bool inverted;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      padding: EdgeInsets.fromLTRB(
          16 * fem, inverted ? 0 : 16 * fem, 0 * fem, inverted ? 16 : 0),
      height: 100,
      width: 140,
      decoration: BoxDecoration(
        color: Color(0xffedf5fc),
        borderRadius: BorderRadius.circular(12 * fem),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (inverted)
            Align(alignment: Alignment.centerRight, child: image)
          else
            SizedBox(
              width: double.maxFinite,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w500,
                  height: 1.6000000238 * ffem / fem,
                  color: Color(0xff1a1c22),
                ),
              ),
            ),
          if (inverted)
            SizedBox(
              width: double.maxFinite,
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w500,
                  height: 1.6000000238 * ffem / fem,
                  color: Color(0xff1a1c22),
                ),
              ),
            )
          else
            Align(alignment: Alignment.centerRight, child: image),
        ],
      ),
    );
  }
}
