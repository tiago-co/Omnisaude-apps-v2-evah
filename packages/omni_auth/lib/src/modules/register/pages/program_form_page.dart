import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/register/stores/register_store.dart';
import 'package:omni_general/omni_general.dart'
    show
        BottomButtonType,
        BottomButtonWidget,
        NewBeneficiaryModel,
        TextFieldWidget;
import 'package:omni_register_labels/labels.dart';

class ProgramFormPage extends StatefulWidget {
  final PageController pageController;

  const ProgramFormPage({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  _ProgramFormPageState createState() => _ProgramFormPageState();
}

class _ProgramFormPageState extends State<ProgramFormPage> {
  late final TextEditingController programController;
  final RegisterStore store = Modular.get();
  // final RegisterVeracruzStore registerVeracruzStore = Modular.get();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool validatePsp = false;

  @override
  void initState() {
    programController = TextEditingController(
      text: store.state.programCode ?? '',
    );

    super.initState();
  }

  @override
  void dispose() {
    programController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            RegisterLabels.programFormMainText,
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
            child: Form(
              key: _formKey,
              child: _buildFormWidget,
            ),
          ),
        ),
        TripleBuilder(
          store: store,
          builder: (_, triple) {
            return BottomButtonWidget(
              onPressed: () async {
                await store.verifyPsp(store.state.programCode!).then(
                  (value) {
                    _formKey.currentState!.reset();
                    widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate,
                    );
                  },
                ).catchError(
                  (onError) {
                    validatePsp = false;
                    _formKey.currentState!.validate();
                  },
                );
              },
              isDisabled: store.isDisabled(page: 1),
              isLoading: triple.isLoading,
              buttonType: BottomButtonType.outline,
              text: RegisterLabels.next,
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
        return TextFieldWidget(
          label: RegisterLabels.programFormCodeLabel,
          placeholder: RegisterLabels.programFormCodePlaceholder,
          isEnabled: !triple.isLoading,
          controller: programController,
          textCapitalization: TextCapitalization.characters,
          onSubmitted: (String input) {},
          suffixIcon: const Icon(Icons.code_rounded),
          enableSuggestions: false,
          onChange: (String? input) {
            triple.state.programCode = input ?? '';
            store.updateForm(triple.state);
          },
          validator: (psp) {
            if (validatePsp) {
              return null;
            } else {
              return RegisterLabels.programFormCodeError;
            }
          },
        );
      },
    );
  }
}
