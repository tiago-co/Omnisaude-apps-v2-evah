import 'package:flutter/material.dart';
import 'package:omni_auth/src/modules/sign_up/widgets/welcome_form_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // pleasefillinallfieldstocomplet (4511:30507)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),

                  child: Text(
                    'Please fill in all fields to complete registration',
                    style: TextStyle(
                      fontSize: 22 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.2999999306 * ffem / fem,
                      color: const Color(0xff1a1c22),
                    ),
                  ),
                ),
                Container(
                  // autogroupga3rDM1 (MYmNg4BKgKm5iLVNgHGA3R)
                  padding:
                      EdgeInsets.fromLTRB(0 * fem, 28 * fem, 1 * fem, 7 * fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // frame3ioZ (4511:30508)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 4 * fem),
                        width: double.infinity,
                        height: 556 * fem,
                        child: const Column(
                          children: [
                            WelcomeFormField(label: 'Nome completo'),
                            SizedBox(
                              height: 12,
                            ),
                            WelcomeFormField(label: 'Data de Nascimento'),
                            SizedBox(
                              height: 12,
                            ),
                            WelcomeFormField(label: 'Número de telefone'),
                            SizedBox(
                              height: 12,
                            ),
                            WelcomeFormField(label: 'Endereço'),
                            SizedBox(
                              height: 12,
                            ),
                            WelcomeFormField(label: 'Estado Civil'),
                            SizedBox(
                              height: 12,
                            ),
                            WelcomeFormField(label: 'Altura (cm)'),
                            SizedBox(
                              height: 12,
                            ),
                            WelcomeFormField(label: 'Peso (kg)'),
                            SizedBox(
                              height: 12,
                            ),
                            WelcomeFormField(label: 'Contato de emergência'),
                          ],
                        ),
                      ),
                      Container(
                        // masterbuttonmasterPqh (I4511:30516;19:7770)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 34 * fem),
                        padding: EdgeInsets.fromLTRB(
                            0 * fem, 16 * fem, 0.5 * fem, 16 * fem),

                        height: 56 * fem,
                        decoration: BoxDecoration(
                          color: true
                              ? const Color(0xff2D73B3)
                              : const Color(0xffbbd2e6),
                          borderRadius: BorderRadius.circular(60 * fem),
                        ),
                        child: Container(
                          // autogroupu5ougpo (MYmRPPppj9ubWD8BZ7U5ou)
                          padding: EdgeInsets.fromLTRB(
                              1.5 * fem, 0 * fem, 0 * fem, 0 * fem),
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(
                            child: Text(
                              'Complete',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.5 * ffem / fem,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
