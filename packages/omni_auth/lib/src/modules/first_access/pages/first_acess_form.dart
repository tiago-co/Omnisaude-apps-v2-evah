import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/first_access/store/first_acess_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_general/src/core/enums/first_acess_send_to_enum.dart';
import 'package:omni_login_labels/labels.dart';

class FirstAcessForm extends StatefulWidget {
  const FirstAcessForm({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<FirstAcessForm> createState() => _FirstAcessFormState();
}

class _FirstAcessFormState extends State<FirstAcessForm> {
  FirstAcessStore store = Modular.get();

  void _insertOverlay(BuildContext context, FirstAcessType selected) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return SizedBox();
    });
    overlayEntry = OverlayEntry(
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return Positioned(
          width: size.width,
          child: SafeArea(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 3), // changes position of shadow
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        selected == FirstAcessType.whatsApp
                            ? 'Mensagem enviada! Verifique no seu aplicativo do WhatsApp'
                            : 'Email enviado! Caso não encontre, verifique a sua caixa de spam',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.6,
                          color: Color(0xff232120),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => overlayEntry.remove(),
                        child: Text(
                          'Fechar',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.6,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(overlayEntry);
    await Future.delayed(const Duration(seconds: 5));
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  }

  Widget _buildRadioItemWidget(BuildContext context, FirstAcessType status) {
    return TripleBuilder(
      store: store,
      builder: (context, triple) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: RadioListTile<FirstAcessType>(
            value: status,
            groupValue: store.selected,
            onChanged: (FirstAcessType? value) async {
              // setState(() {
              store.selected = value ?? store.selected;
              store.state.sendTo = value;
              store.updateForm(store.state);
              // });
            },
            dense: true,
            activeColor: Theme.of(context).primaryColor,
            contentPadding: EdgeInsets.zero,
            title: Text(
              status == FirstAcessType.whatsApp ? 'WhatsApp' : 'E-mail',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        );
      },
    );
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
                  'Link de ativação e criação de senha',
                  style: TextStyle(
                    fontSize: 28 * fem,
                    fontWeight: FontWeight.w600,
                    height: 1.2000000817 * fem / fem,
                    color: Color(0xff1a1c22),
                  ),
                ),
              ),
              Text(
                'Para ativar sua conta iremos te enviar um link para criação da sua primeira senha',
                style: TextStyle(
                  fontSize: 16 * fem,
                  fontWeight: FontWeight.w400,
                  height: 1.6000000238 * fem / fem,
                  color: const Color(0xff232120),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Selecione onde você deseja receber o link',
                style: TextStyle(
                  fontSize: 16 * fem,
                  fontWeight: FontWeight.w600,
                  height: 1.5 * fem / fem,
                  color: const Color(0xff232120),
                ),
              ),
              const SizedBox(height: 16),
              if (store.containPhone != null)
                _buildRadioItemWidget(context, FirstAcessType.whatsApp)
              else
                const SizedBox(),
              _buildRadioItemWidget(context, FirstAcessType.email),
              const SizedBox(height: 24),
              TripleBuilder(
                store: store,
                builder: (context, triple) {
                  return ElevatedButton(
                    onPressed: triple.isLoading
                        ? null
                        : () async {
                            await store
                                .sendActivationLink()
                                .then((value) => _insertOverlay(context, store.selected))
                                .catchError((onError) {
                              Helpers.showDialog(
                                context,
                                RequestErrorWidget(
                                  error: onError,
                                  buttonText: LoginLabels.close,
                                  onPressed: () => Modular.to.pop(),
                                ),
                                showClose: true,
                              );
                            });
                            // Modular.to.navigate('/auth/newLogin/');
                          },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Theme.of(context).primaryColor,
                        disabledBackgroundColor: Theme.of(context).primaryColor),
                    child: Container(
                      height: 56 * fem,
                      child: SizedBox.expand(
                        child: triple.isLoading
                            ? const LoadingWidget(
                                indicatorColor: Colors.white,
                              )
                            : Center(
                                child: Text(
                                  'Enviar',
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
// id=OQ&token=c30s3y-5a21f77fa6b33eda877f8073762a2fae
// adb shell 'am start -d "http://backend.evahsaude.com.br/auth/password/resetPassword?id=OQ&token=c30s3y-5a21f77fa6b33eda877f8073762a2fae"'
// adb shell 'am start -d "https://backend.evahsaude.com.br/auth/password/resetPassword?id=MjA&token=c33z2v-e0d0255d00433b1423eaf9e738d9e5c4"'