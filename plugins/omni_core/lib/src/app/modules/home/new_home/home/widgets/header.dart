import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';

class Header extends StatelessWidget {
  Header();
  final UserStore userStore = Modular.get();
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return TripleBuilder(
      store: userStore,
      builder: (context, triple) {
        if (triple.isLoading) {
          return const LoadingWidget();
        }
        return Container(
          margin: EdgeInsets.fromLTRB(0 * fem, 20 * fem, 0 * fem, 28 * fem),
          width: double.infinity,
          height: 40 * fem,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                height: double.infinity,
                child: Row(
                  children: [
                    SizedBox(
                      width: 40 * fem,
                      height: 40 * fem,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 22 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.2999999306 * ffem / fem,
                          color: Color(0xff1a1c22),
                        ),
                        children: [
                          TextSpan(
                            text: 'Olá, ',
                            style: TextStyle(
                              fontSize: 22 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.2999999306 * ffem / fem,
                              color: Color(0xff52576a),
                            ),
                          ),
                          TextSpan(
                            text: userStore.state.user?.individualPerson?.name?.split(' ').first,
                            style: TextStyle(
                              fontSize: 22 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.2999999306 * ffem / fem,
                              color: Color(0xff1a1c22),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // TextButton(
              //   // iconsQPR (4511:32300)
              //   onPressed: () {
              //     Modular.to.pushNamed(
              //       '/newHome/notifications',
              //       arguments: userStore.userId,
              //     );
              //   },
              //   style: TextButton.styleFrom(
              //     padding: EdgeInsets.zero,
              //   ),
              //   child: CircleAvatar(
              //       backgroundColor: Colors.grey.shade100,
              //       child: const Icon(
              //         Icons.notifications_none_rounded,
              //         size: 28,
              //         color: Colors.black,
              //       )),
              // ),
            ],
          ),
        );
      },
    );
  }
}
