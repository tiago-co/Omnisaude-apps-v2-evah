import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/reset_password/reset_password_store.dart';
import 'package:omni_general/omni_general.dart';

class NewPasswordResetPage extends StatefulWidget {
  NewPasswordResetPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordResetPage> createState() => _NewPasswordResetPageState();
}

class _NewPasswordResetPageState extends State<NewPasswordResetPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatController = TextEditingController();

  final ResetPasswordStore store = Modular.get();
  late final String token;
  late final String id;

  bool isObscure = true;

  bool validate(BuildContext context) {
    if (passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Senha deve conter no mínimo 6 caracteres!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
      return false;
    } else if (passwordController.text != repeatController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Senhas não coincidem!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    store.state.token = Modular.args.queryParams['token'] ?? '';
    store.state.id = Modular.args.queryParams['id'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 40),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Por favor, digite uma senha para sua conta',
                style: TextStyle(
                  fontSize: 22 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 1.2999999306 * ffem / fem,
                  color: Color(0xff1a1c22),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldWidget(
                label: 'Senha',
                controller: passwordController,
                focusedborder: InputBorder.none,
                padding: EdgeInsets.zero,
                obscureText: isObscure,
                maxLines: 1,
                suffixIcon: InkWell(
                  onTap: () => setState(() {
                    isObscure = !isObscure;
                  }),
                  child: Icon(
                    isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                ),
                onChange: (input) {
                  store.state.password = input;
                  store.updateForm(store.state);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                label: 'Repetir senha',
                controller: repeatController,
                focusedborder: InputBorder.none,
                padding: EdgeInsets.zero,
                obscureText: isObscure,
                maxLines: 1,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  'Mínimo 6 carcteres com pelo menos um número, letra maiúscula e símbolo',
                  style: TextStyle(
                    fontSize: 12 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.3333333333 * ffem / fem,
                    color: Color(0xff878da0),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              TextButton(
                onPressed: () async {
                  if (validate(context)) {
                    await store.newResetPassword(store.state).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            'Senha Atualizada!',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                      Modular.to.navigate('/auth/newLogin');
                    }).catchError((onError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            onError.message,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    });
                  }
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: SizedBox(
                  height: 56 * fem,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xff2d72b3),
                      borderRadius: BorderRadius.circular(60 * fem),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(4 * fem, 0 * fem, 0 * fem, 0 * fem),
                      width: double.infinity,
                      height: double.infinity,
                      child: TripleBuilder(
                        store: store,
                        builder: (context, triple) {
                          if (triple.isLoading) {
                            return const LoadingWidget(
                              indicatorColor: Colors.white,
                            );
                          }
                          return Center(
                            child: Text(
                              'Continuar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.5 * ffem / fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
