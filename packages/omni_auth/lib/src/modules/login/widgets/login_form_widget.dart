import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/login/stores/login_store.dart';
import 'package:omni_auth/src/modules/login/stores/obscure_text_store.dart';
import 'package:omni_general/omni_general.dart'
    show
        DefaultButtonType,
        DefaultButtonWidget,
        Helpers,
        LocalAuthService,
        Masks,
        PreferencesService,
        RequestErrorWidget,
        TextFieldWidget;
import 'package:omni_general/src/core/enums/biometric_type_enum.dart';
import 'package:omni_general/src/core/enums/use_biometric_permission_enum.dart';
import 'package:omni_general/src/stores/use_biometrics_store.dart';
import 'package:omni_login_labels/labels.dart';

class LoginFormWidget extends StatefulWidget {
  final TextEditingController username;
  final TextEditingController password;
  const LoginFormWidget({
    Key? key,
    required this.username,
    required this.password,
  }) : super(key: key);

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final PreferencesService preferencesService = PreferencesService();
  final UseBiometricsStore useBiometricsStore = Modular.get();

  BiometricTypeEnum? biometricType;

  final LoginStore store = Modular.get();
  final mask = Masks.generateMask('#############');

  @override
  void initState() {
    useBiometricsStore.canAuthenticateUser().then(
      (value) {
        LocalAuthService.getBiometricType().then(
          (value) {
            biometricType = biometricEnumFromBiometricType(value);
          },
        );
      },
    );
    useBiometricsStore.getHasBiometrics();

    super.initState();
  }

  void login() {
    store.authenticate(store.state).then(
      (value) {
        Modular.to.pushReplacementNamed('/home/presentation');
      },
    ).catchError(
      (onError) {
        widget.password.clear();
        Helpers.showDialog(
          context,
          RequestErrorWidget(
            error: onError,
            buttonText: LoginLabels.close,
            onPressed: () => Modular.to.pop(),
          ),
          showClose: true,
        );
      },
    );
  }

  @override
  void dispose() {
    usernameFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFieldWidget(
          label: LoginLabels.usernameLabel,
          placeholder: LoginLabels.usernamePlaceholder,
          controller: widget.username,
          focusNode: usernameFocus,
          onSubmitted: (String input) {
            Helpers.changeFocus(context, usernameFocus, passwordFocus);
          },
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.next,
          onChange: (String? input) {
            store.state.username = input;
            store.updateForm(store.state);
          },
          suffixIcon: Icon(
            Icons.account_circle_outlined,
            color: Theme.of(context).primaryColor.withOpacity(1),
          ),
        ),
        _buildPasswordFieldWidget,
      ],
    );
  }

  Widget get _buildPasswordFieldWidget {
    return TripleBuilder<ObscureTextStore, Exception, bool>(
      store: store.obscureTextStore,
      builder: (_, triple) {
        return TextFieldWidget(
          label: LoginLabels.passwordLabel,
          focusNode: passwordFocus,
          placeholder: LoginLabels.passwordPlaceholder,
          controller: widget.password,
          enableSuggestions: false,
          maxLines: 1,
          obscureText: triple.state,
          textCapitalization: TextCapitalization.none,
          suffixIcon: GestureDetector(
            onTap: () {
              store.obscureTextStore.update(!store.obscureTextStore.state);
            },
            child: Icon(
              triple.state
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Theme.of(context).primaryColor.withOpacity(1),
            ),
          ),
          onSubmitted: (String input) {
            FocusScope.of(context).requestFocus(FocusNode());
            if (store.isDisabled) return;
            if (store.useBiometricsStore.canUseBiometricAuth &&
                store.useBiometricsStore.state ==
                    UseBiometricPermission.notAccepted) {
              Helpers.showDialog(
                context,
                Helpers.activateBiometricAuth(
                  context,
                  () => LocalAuthService.authenticate().then(
                    (value) => login.call(),
                  ),
                  biometricType!,
                ),
              );
            } else {
              store.authenticate(store.state).then(
                (value) {
                  Modular.to.pushReplacementNamed(
                    '/home/presentation',
                  );
                },
              ).catchError(
                (onError) {
                  widget.password.clear();
                  store.state.password = null;
                  store.updateForm(store.state);
                  Helpers.showDialog(
                    context,
                    RequestErrorWidget(
                      error: onError,
                      buttonText: LoginLabels.close,
                      onPressed: () => Modular.to.pop(),
                    ),
                    showClose: true,
                  );
                },
              );
            }
          },
          textInputAction: defaultTargetPlatform == TargetPlatform.android
              ? TextInputAction.go
              : TextInputAction.join,
          onChange: (String? input) {
            store.state.password = input;
            store.updateForm(store.state);
          },
        );
      },
    );
  }
}
