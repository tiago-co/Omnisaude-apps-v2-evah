import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/first_access/store/first_acess_store.dart';
import 'package:omni_general/omni_general.dart';

class FirstAcessPage extends StatelessWidget {
  FirstAcessPage({Key? key}) : super(key: key);

  FirstAcessStore store = Modular.get();

  final TextEditingController cpfOrEmail = TextEditingController();

  Widget getErrorMessage(int errorCode) {
    if (errorCode == 403) {
      return TextButton(
        onPressed: () {
          Modular.to.pushNamed('/auth/password');
        },
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.5,
              color: Color(0xff000000),
            ),
            children: [
              TextSpan(
                text: 'Parece que você já fez seu primeiro acesso. ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff9D2121),
                ),
              ),
              TextSpan(
                text: 'Acesse aqui para recuperar a senha.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffF106A7),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (errorCode == 404) {
      return const Text(
        'Este CPF ou e-mail não está associado a nenhuma conta. Verifique dados ou clique em Cadastrar.',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xff9D2121),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Primeiro acesso',
          style: TextStyle(
            fontSize: 16 * fem,
            fontWeight: FontWeight.w600,
            color: const Color(0xff1a1c22),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Modular.to.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xff1a1c22),
            size: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16 * fem),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // welcomebackdDH (4511:30467)
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 4 * fem),
                child: Text(
                  'Bem-vindo!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28 * fem,
                    fontWeight: FontWeight.w600,
                    height: 1.2000000817 * fem / fem,
                    color: Color(0xff1a1c22),
                  ),
                ),
              ),
              Text(
                'Esse é seu primeiro acesso ao Médico na Hora. Estamos muito felizes em ter você',
                style: TextStyle(
                  fontSize: 16 * fem,
                  fontWeight: FontWeight.w400,
                  height: 1.6000000238 * fem / fem,
                  color: const Color(0xff232120),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Para começar precisamos do seu CPF ou E-mail usado no seu cadastro',
                style: TextStyle(
                  fontSize: 16 * fem,
                  fontWeight: FontWeight.w600,
                  height: 1.5 * fem / fem,
                  color: const Color(0xff232120),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: TextFieldWidget(
                  label: 'CPF ou E-mail',
                  controller: cpfOrEmail,
                  focusedborder: InputBorder.none,
                  padding: EdgeInsets.zero,
                  textCapitalization: TextCapitalization.none,
                  fem: fem,
                  onChange: (String? input) {
                    store.state.cpfOrEmail = input;
                    store.updateForm(store.state);
                  },
                ),
              ),
              const SizedBox(height: 8),
              TripleBuilder<FirstAcessStore, DioError, Object>(
                store: store,
                builder: (context, triple) {
                  if (triple.event == TripleEvent.error) {
                    return getErrorMessage(triple.error!.response!.statusCode!);
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 24),
              TripleBuilder(
                store: store,
                builder: (context, triple) {
                  return ElevatedButton(
                    onPressed: store.isDisabled
                        ? null
                        : () async {
                            if (!triple.isLoading) {
                              triple.clearError();
                              await store.verifyUser();
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Theme.of(context).primaryColor,
                      disabledBackgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: Container(
                      height: 56 * fem,
                      child: SizedBox.expand(
                        child: Center(
                          child: triple.isLoading
                              ? const LoadingWidget(
                                  indicatorColor: Colors.white,
                                )
                              : Text(
                                  'Continuar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5 * fem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// adb shell 'am start -d "https://backend.evahsaude.com.br/auth/signUp/emailConfirmation?id=Nw&token=c2uqbd-5aa24570fa80b189a673873b867e0750"'
