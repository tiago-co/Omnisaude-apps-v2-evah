import 'package:flutter/material.dart';

class ServiceButton extends StatelessWidget {
  const ServiceButton({required this.image, required this.title, required this.color, this.inverted = false});
  final Widget image;
  final String title;
  final bool inverted;
  final Color color;
  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width > 500 ? 500 : 375;

    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return LayoutBuilder(
      builder: (context, constraints) => Container(
          padding: EdgeInsets.fromLTRB(12 * fem, inverted ? 0 : 8 * fem, 4 * fem, inverted ? 8 : 0),
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12 * fem),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0.5, 2),
                blurRadius: 2,
                spreadRadius: 0.1,
                color: Colors.black12,
              )
            ],
          ),
          child: inverted
              ? Stack(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 1.3,
                      width: constraints.maxWidth * 1.5,
                      child: Stack(
                        children: [
                          Positioned(
                            top: -0,
                            right: 0,
                            child: image,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: SizedBox(
                        width: constraints.maxWidth,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            // maxLines: 2,
                            // softWrap: false,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16 * ffem,
                              overflow: TextOverflow.fade,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1a1c22),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * 2.5,
                      width: constraints.maxWidth * 1.9,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: image,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SizedBox(
                        width: constraints.maxWidth,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            // maxLines: 2,
                            // softWrap: false,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16 * ffem,
                              overflow: TextOverflow.fade,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1a1c22),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
          // Column(
          //   // crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     if (inverted)
          //       Align(
          //         alignment: Alignment.centerRight,
          //         child: AspectRatio(
          //           aspectRatio: fem > 2 ? fem : fem + 1,
          //           child: image,
          //         ),
          //       )
          //     else
          //       SizedBox(
          //         width: double.maxFinite,
          //         child: Align(
          //           alignment: Alignment.centerLeft,
          //           child: FittedBox(
          //             fit: BoxFit.scaleDown,
          //             child: Text(
          //               title,
          //               maxLines: 1,
          //               softWrap: false,
          //               textAlign: TextAlign.left,
          //               style: TextStyle(
          //                 fontSize: 16 * ffem,
          //                 overflow: TextOverflow.fade,
          //                 fontWeight: FontWeight.w500,
          //                 color: Color(0xff1a1c22),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     if (inverted)
          //       SizedBox(
          //         width: double.maxFinite,
          //         child: Align(
          //           alignment: Alignment.centerLeft,
          //           child: FittedBox(
          //             fit: BoxFit.scaleDown,
          //             child: Text(
          //               title,
          //               textAlign: TextAlign.left,
          //               style: TextStyle(
          //                 fontSize: 16 * ffem,
          //                 fontWeight: FontWeight.w500,
          //                 height: 1.6000000238 * ffem / fem,
          //                 color: Color(0xff1a1c22),
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //     else
          //       Align(
          //         alignment: Alignment.centerRight,
          //         child: AspectRatio(
          //           aspectRatio: fem > 2 ? fem : fem + 1,
          //           child: image,
          //         ),
          //       ),
          //   ],
          // ),
          ),
    );
  }
}
