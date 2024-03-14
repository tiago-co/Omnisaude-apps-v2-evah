import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/new_login/reset_password/reset_password_store.dart';
import 'package:omni_auth/src/modules/new_reset_password/store/request_reset_password_store.dart';
import 'package:omni_general/omni_general.dart';

class RequestResetPasswordPage extends StatefulWidget {
  RequestResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<RequestResetPasswordPage> createState() => _RequestResetPasswordPageState();
}

class _RequestResetPasswordPageState extends State<RequestResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  final RequestResetPasswordStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 42,
            color: Colors.black54,
          ),
          onPressed: () {
            Modular.to.pop();
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20 * ffem),
          padding: EdgeInsets.all(20 * ffem),
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Por favor, digite o e-mail para redefinirmos a senha',
                style: TextStyle(
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 1.2999999306 * ffem / fem,
                  color: const Color(0xff1a1c22),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldWidget(
                label: 'E-mail',
                controller: emailController,
                focusedborder: InputBorder.none,
                padding: EdgeInsets.zero,
                textCapitalization: TextCapitalization.none,
                fem: ffem,
                onChange: (input) {
                  input = input?.toLowerCase();
                  store.update(input?.toLowerCase() ?? '');
                },
              ),
              const SizedBox(
                height: 32,
              ),
              TripleBuilder(
                store: store,
                builder: (context, triple) {
                  return ElevatedButton(
                    onPressed: !store.isDisabled && !store.isLoading
                        ? () async {
                            await store.requestPasswordReset(emailController.text).then(
                              (value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      'Verifique seu email!',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                                Modular.to.pushNamed('/auth/newLogin');
                              },
                            ).catchError((onError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    '${onError.message}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            });
                            // ;
                          }
                        : null,
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    ),
                    child: Container(
                      height: 56 * fem,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: store.isDisabled ? const Color(0xff2d72b3).withOpacity(0.7) : const Color(0xff2d72b3),
                          borderRadius: BorderRadius.circular(60 * fem),
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(4 * fem, 0 * fem, 0 * fem, 0 * fem),
                          width: double.infinity,
                          height: double.infinity,
                          child: triple.isLoading
                              ? const LoadingWidget(
                                  indicatorColor: Colors.white,
                                )
                              : Center(
                                  child: Text(
                                    'Continuar',
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
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
