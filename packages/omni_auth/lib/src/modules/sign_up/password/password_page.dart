import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/register/stores/register_store.dart';
import 'package:omni_auth/src/modules/sign_up/widgets/welcome_form_field.dart';
import 'package:omni_general/omni_general.dart';

class PasswordPage extends StatefulWidget {
  PasswordPage({Key? key}) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final TextEditingController passwordController = TextEditingController();

  final RegisterStore store = Modular.get();
  late final String token;
  late final String id;
  @override
  void initState() {
    super.initState();
    token = Modular.args.queryParams['token'] ?? '';
    id = Modular.args.queryParams['id'] ?? '';
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
                onChange: (String? input) {
                  store.state.individualPerson?.user = UserModel(password: input);
                  store.updateForm(store.state);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                // captionoLb (I201:17512;1302:19293;1302:19102)
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  'Mínimo 8 carcteres com pelo menos um número, letra maiúscula e símbolo',
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
              Container(
                // buttonprimaryJHM (202:13947)

                child: TextButton(
                  onPressed: () async {
                    await store
                        .confirmUser(id, token, passwordController.text)
                        .then((value) => Modular.to.pushNamed('/auth/signUp/signUpPage'))
                        .catchError((onError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.white,
                          content: Text("Ocorreu um erro!"),
                        ),
                      );
                    });
                    // ;
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Container(
                    height: 56 * fem,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xff2d72b3),
                        borderRadius: BorderRadius.circular(60 * fem),
                      ),
                      child: Container(
                        // autogroupej3hLUw (MYqhTWybfzWVF6h6TyeJ3h)
                        padding: EdgeInsets.fromLTRB(4 * fem, 0 * fem, 0 * fem, 0 * fem),
                        width: double.infinity,
                        height: double.infinity,
                        child: Center(
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
                        ),
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
