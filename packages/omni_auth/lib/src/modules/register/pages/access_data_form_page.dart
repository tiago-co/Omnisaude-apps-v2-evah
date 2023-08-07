import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/register/pages/widgets/terms_check_box_widget.dart';
import 'package:omni_auth/src/modules/register/stores/register_store.dart';
import 'package:omni_general/omni_general.dart'
    show
        BottomButtonWidget,
        Helpers,
        NewBeneficiaryModel,
        RequestErrorWidget,
        TextFieldWidget;
import 'package:omni_register_labels/labels.dart';

class AccessDataFormPage extends StatefulWidget {
  final PageController pageController;

  const AccessDataFormPage({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  _AccessDataFormPageState createState() => _AccessDataFormPageState();
}

class _AccessDataFormPageState extends State<AccessDataFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  final FocusNode emailFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  final RegisterStore store = Modular.get();
  // final RegisterVeracruzStore registerVeracruzStore = Modular.get();

  @override
  void initState() {
    emailController = TextEditingController(
      text: store.state.individualPerson?.user?.email,
    );

    usernameController = TextEditingController(
      text: store.state.individualPerson?.user?.username,
    );

    passwordController = TextEditingController(
      text: '',
    );
    confirmPasswordController = TextEditingController(
      text: '',
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    emailFocus.dispose();
    usernameFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
  }

  Future<void> registerBeneficiary() async {
    if (_formKey.currentState!.validate()) {
      await store.registerBeneficiary(store.state).then((value) {
        widget.pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate,
        );
      }).catchError((onError) {
        Helpers.showDialog(
          context,
          RequestErrorWidget(
            error: onError,
            buttonText: RegisterLabels.close,
            onPressed: () => Modular.to.pop(),
          ),
          showClose: true,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            RegisterLabels.accessDataFormMainText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            RegisterLabels.securityText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 15),
        const Divider(height: 1),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.all(15),
            child: _buildFormWidget,
          ),
        ),
        TripleBuilder(
          store: store,
          builder: (_, triple) {
            return BottomButtonWidget(
              onPressed: registerBeneficiary,
              isDisabled: store.isDisabled(page: 4),
              isLoading: triple.isLoading,
              text: RegisterLabels.save,
            );
          },
        ),
      ],
    );
  }

  Widget get _buildFormWidget {
    return TripleBuilder<RegisterStore, DioError, NewBeneficiaryModel>(
      store: store,
      builder: (_, triple) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFieldWidget(
                label: RegisterLabels.accessDataFormEmailLabel,
                placeholder: RegisterLabels.accessDataFormEmailPlaceholder,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                focusNode: emailFocus,
                controller: emailController,
                onChange: (String? input) {
                  triple.state.individualPerson!.user!.email = input;
                  store.updateForm(store.state);
                },
                onSubmitted: (String input) {
                  Helpers.changeFocus(_, emailFocus, usernameFocus);
                },
              ),
              const SizedBox(height: 15),
              TextFieldWidget(
                label: RegisterLabels.accessDataFormUsernameLabel,
                placeholder: RegisterLabels.accessDataFormUsernamePlaceholder,
                focusNode: usernameFocus,
                controller: usernameController,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.none,
                onChange: (String? input) {
                  triple.state.individualPerson!.user!.username = input;
                  store.updateForm(store.state);
                },
                onSubmitted: (String input) {
                  Helpers.changeFocus(_, usernameFocus, passwordFocus);
                },
              ),
              const SizedBox(height: 15),
              TextFieldWidget(
                label: RegisterLabels.accessDataFormPasswordLabel,
                placeholder: RegisterLabels.accessDataFormPasswordPlaceholder,
                isEnabled: !triple.isLoading,
                focusNode: passwordFocus,
                controller: passwordController,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                obscureText: true,
                maxLines: 1,
                validator: (String? input) {
                  if (input!.isEmpty) {
                    return RegisterLabels.emptyFildError;
                  } else {
                    return null;
                  }
                },
                onChange: (String? input) {
                  triple.state.individualPerson!.user!.password = input;
                  store.updateForm(store.state);
                },
                onSubmitted: (String input) {
                  Helpers.changeFocus(_, passwordFocus, confirmPasswordFocus);
                },
              ),
              const SizedBox(height: 15),
              TextFieldWidget(
                label: RegisterLabels.accessDataFormConfirmPasswordLabel,
                placeholder:
                    RegisterLabels.accessDataFormConfirmPasswordPlaceholder,
                isEnabled: !triple.isLoading,
                obscureText: true,
                focusNode: confirmPasswordFocus,
                controller: confirmPasswordController,
                maxLines: 1,
                validator: (String? input) {
                  if (input!.isEmpty) {
                    return RegisterLabels.emptyFildError;
                  }
                  if (input == passwordController.text) {
                    return null;
                  } else {
                    return RegisterLabels
                        .accessDataFormConfirmPasswordInaqualityError;
                  }
                },
                textCapitalization: TextCapitalization.none,
                onChange: (String? input) {
                  triple.state.individualPerson!.user!.password = input;
                  store.updateForm(store.state);
                },
                onSubmitted: (String input) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
              const SizedBox(height: 15),
              Opacity(
                opacity: triple.isLoading ? 0.5 : 1.0,
                child: AbsorbPointer(
                  absorbing: triple.isLoading,
                  child: const TermsCheckBoxWidget(),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }
}
