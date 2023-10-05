import 'package:flutter/material.dart';
import 'package:omni_auth/src/modules/sign_up/widgets/welcome_form_field.dart';

class NewResetPasswordPage extends StatelessWidget {
  const NewResetPasswordPage();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          // resetpasswordPqy (5103:11995)
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // autogroup6c6sioh (MYnnKNoknk8jRfZzzF6c6s)
                padding:
                    EdgeInsets.fromLTRB(20 * fem, 92 * fem, 1 * fem, 7 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // frame2EX9 (5103:11999)
                      margin: EdgeInsets.fromLTRB(
                          59 * fem, 0 * fem, 78 * fem, 28 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // resetpasswordZ3d (5103:12000)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 4 * fem),
                            child: Text(
                              'Reset password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.2000000817 * ffem / fem,
                                color: Color(0xff1a1c22),
                              ),
                            ),
                          ),
                          Text(
                            // createnewpasswordFSF (5103:12001)
                            'Create new password.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.6000000238 * ffem / fem,
                              color: Color(0xff52576a),
                            ),
                          ),
                        ],
                      ),
                    ),
                    WelcomeFormField(label: 'Senha atual'),
                    SizedBox(
                      height: 12,
                    ),
                    WelcomeFormField(label: 'Nova Senha'),
                    SizedBox(height: 12),
                    WelcomeFormField(label: 'Confirmar Senha'),
                    SizedBox(height: 24),
                    Container(
                      // buttonprimary53D (5103:12006)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 19 * fem, 204 * fem),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Container(
                          width: 335 * fem,
                          height: 56 * fem,
                          child: Container(
                            // masterbuttonmasteraVm (I5103:12006;19:7770)
                            padding: EdgeInsets.fromLTRB(
                                105.5 * fem, 16 * fem, 105.5 * fem, 16 * fem),
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color:
                                  true ? Color(0xff2D73B3) : Color(0xffbbd2e6),
                              borderRadius: BorderRadius.circular(60 * fem),
                            ),
                            child: Container(
                              // autogroupit8fW8X (MYnopFUfmMojGGVnrkit8F)
                              width: double.infinity,
                              height: double.infinity,
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'Reset password',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.5 * ffem / fem,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
