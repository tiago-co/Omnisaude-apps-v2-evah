import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/register/pages/widgets/responsable_data_form_widget.dart';
import 'package:omni_auth/src/modules/register/stores/register_store.dart';
import 'package:omni_general/omni_general.dart';

import 'package:omni_register_labels/labels.dart';

class VerifyPersonalDataPage extends StatefulWidget {
  final PageController pageController;

  const VerifyPersonalDataPage({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  _VerifyPersonalDataPageState createState() => _VerifyPersonalDataPageState();
}

class _VerifyPersonalDataPageState extends State<VerifyPersonalDataPage> {
  final DateTimePickerService service = DateTimePickerService();
  late final TextEditingController birthController;
  late final TextEditingController cpfController;
  late final TextEditingController registrationController;
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController genreController;

  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();

  final RegisterStore store = Modular.get();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    cpfController = TextEditingController(
      text: store.state.individualPerson?.cpf != null ? Formaters.formatCPF(store.state.individualPerson!.cpf!) : '',
    );
    birthController = TextEditingController(
      text: store.state.individualPerson?.birth ?? '',
    );

    registrationController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    genreController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    service.dispose();
    registrationController.dispose();
    cpfController.dispose();
    birthController.dispose();
    super.dispose();
  }

  void chooseBirthDate() {
    service
        .selectDate(
      context,
      enablePastDates: true,
      maxDate: DateTime.now(),
      minDate: DateTime(1900),
      initialDisplayDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
    )
        .then(
      (birth) {
        if (birth == null) return;

        birthController.text = Formaters.dateToStringDate(birth);
        store.state.individualPerson!.birth = birthController.text;

        store.updateForm(store.state);
      },
    ).whenComplete(() => FocusScope.of(context).requestFocus(FocusNode()));
  }

  Future<void> verifyUser() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState!.validate()) {
      final Map<String, String> params = {
        'dt_nascimento': birthController.text,
        'cpf': cpfController.text.replaceAll(RegExp(r'[^0-9]'), ''),
        // 'nr_matricula': registrationController.text,
      };
      store.verifyUser(params).then(
        (value) {
          if (store.isUnderage()) {
            store.state.responsible = BeneficiaryResponsibleModel();
          }
          widget.pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
          );
        },
      ).catchError(
        (onError) {
          log(onError.toString());
          Helpers.showDialog(
            context,
            RequestErrorWidget(
              error: onError,
              onPressed: () => Modular.to.pop(),
              buttonText: RegisterLabels.close,
            ),
          );
        },
      );
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
            RegisterLabels.verifyPersonalDataMainText,
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: _buildFormWidget,
          ),
        ),
        TripleBuilder(
          store: store,
          builder: (_, triple) {
            return BottomButtonWidget(
              onPressed: verifyUser,
              isDisabled: store.isDisabled(page: 0),
              isLoading: triple.isLoading,
              buttonType: BottomButtonType.outline,
              text: RegisterLabels.next,
            );
          },
        )
      ],
    );
  }

  Widget get _buildFormWidget {
    final mask = Masks.generateMask('###.###.###-##');
    return TripleBuilder<RegisterStore, DioError, NewBeneficiaryModel>(
      store: store,
      builder: (_, triple) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFieldWidget(
                label: RegisterLabels.verifyPersonalDataCPFLabel,
                controller: cpfController,
                placeholder: RegisterLabels.verifyPersonalDataCPFPlaceholder,
                isEnabled: !triple.isLoading,
                keyboardType: TextInputType.number,
                onChange: (String? input) {
                  if (input == null) return;
                  store.state.individualPerson!.cpf = input.replaceAll(RegExp(r'[^0-9]'), '');
                  store.updateForm(store.state);
                },
                validator: (String? input) {
                  if (Helpers.cpfIsValid(input!)) {
                    return null;
                  } else {
                    return RegisterLabels.verifyPersonalDataCPFError;
                  }
                },
                mask: mask,
                suffixIcon: const Icon(Icons.portrait_rounded),
              ),
              const SizedBox(height: 15),
              TextFieldWidget(
                label: RegisterLabels.verifyPersonalDataBirthDateLabel,
                placeholder: RegisterLabels.verifyPersonalDataBirthDatePlaceholder,
                readOnly: true,
                isEnabled: !triple.isLoading,
                controller: birthController,
                onTap: chooseBirthDate,
                suffixIcon: const Icon(Icons.date_range),
              ),
              const SizedBox(height: 15),
              TextFieldWidget(
                label: RegisterLabels.personalDataFormFullNameLabel,
                controller: nameController,
                placeholder: RegisterLabels.personalDataFormFullNamePlaceholder,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                focusNode: nameFocus,
                onSubmitted: (String input) {
                  Helpers.changeFocus(context, nameFocus, phoneFocus);
                },
                onChange: (String? input) {
                  store.state.individualPerson!.name = input ?? '';
                  store.updateForm(store.state);
                },
              ),
              const SizedBox(height: 15),
              TextFieldWidget(
                label: RegisterLabels.personalDataFormPhoneLabel,
                placeholder: RegisterLabels.personalDataFormPhonePlaceholder,
                mask: Masks.generateMask('(##) # ####-####'),
                controller: phoneController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: phoneFocus,
                onSubmitted: (String input) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                onChange: (String? input) {
                  input = input!.replaceAll('(', '');
                  input = input.replaceAll(')', '');
                  input = input.replaceAll('-', '');
                  input = input.replaceAll(' ', '');
                  store.state.individualPerson!.phone = input;
                  // store.updateForm(store.state);
                },
              ),
              const SizedBox(height: 15),
              SelectFieldWidget<GenreType>(
                label: RegisterLabels.personalDataFormGenreLabel,
                items: GenreType.values,
                itemsLabels: GenreType.values.map((type) => type.label).toList(),
                placeholder: RegisterLabels.personalDataFormGenrePlaceholder,
                controller: genreController,
                // focusNode: genreFocus,
                onSelectItem: (GenreType type) {
                  genreController.text = type.label;
                  store.state.individualPerson!.genre = type;
                  store.updateForm(store.state);
                  // Helpers.changeFocus(context, genreFocus, bloodTypeFocus);
                },
              ),
              const SizedBox(height: 15),
              if (store.isUnderage()) const ResponsableDataFormWidget(),
            ],
          ),
        );
      },
    );
  }
}
