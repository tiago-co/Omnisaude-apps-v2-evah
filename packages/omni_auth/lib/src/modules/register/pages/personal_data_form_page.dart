import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/register/pages/widgets/responsable_data_form_widget.dart';
import 'package:omni_auth/src/modules/register/stores/register_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_register_labels/labels.dart';

class PersonalDataFormPage extends StatefulWidget {
  final PageController pageController;

  const PersonalDataFormPage({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  _PersonalDataFormPageState createState() => _PersonalDataFormPageState();
}

class _PersonalDataFormPageState extends State<PersonalDataFormPage> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;

  final FocusNode nameFocus = FocusNode();
  final FocusNode motherNameFocus = FocusNode();
  final FocusNode fatherNameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode ethnicityFocus = FocusNode();
  final FocusNode genreFocus = FocusNode();
  final FocusNode bloodTypeFocus = FocusNode();

  final RegisterStore store = Modular.get();

  @override
  void initState() {
    nameController = TextEditingController(
      text: store.state.individualPerson?.name,
    );
    phoneController = TextEditingController(
      text: store.state.individualPerson?.phone,
    );


    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();

    nameFocus.dispose();
    motherNameFocus.dispose();
    fatherNameFocus.dispose();
    phoneFocus.dispose();
    ethnicityFocus.dispose();
    genreFocus.dispose();
    bloodTypeFocus.dispose();
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
            RegisterLabels.personalDataFormMainText,
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
            child: _buildFormBodyWidget,
          ),
        ),
        TripleBuilder(
          store: store,
          builder: (_, triple) {
            return BottomButtonWidget(
              onPressed: () {
                widget.pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                );
              },
              isDisabled: store.isDisabled(page: 2),
              buttonType: BottomButtonType.outline,
              text: RegisterLabels.next,
            );
          },
        ),
      ],
    );
  }

  Widget get _buildFormBodyWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
        // TextFieldWidget(
        //   label: RegisterLabels.personalDataFormMotherNameLabel,
        //   placeholder: RegisterLabels.personalDataFormMotherNamePlaceholder,
        //   controller: motherNameController,
        //   textCapitalization: TextCapitalization.words,
        //   textInputAction: TextInputAction.next,
        //   focusNode: motherNameFocus,
        //   onSubmitted: (String input) {
        //     log('onSubmitted');
        //     // Helpers.changeFocus(context, motherNameFocus, fatherNameFocus);
        //     FocusScope.of(context).requestFocus(fatherNameFocus);
        //   },
        //   onChange: (String? input) {
        //     store.state.individualPerson!.motherName = input ?? '';
        //     store.updateForm(store.state);
        //   },
        // ),
        // const SizedBox(height: 15),
        // TextFieldWidget(
        //   label: RegisterLabels.personalDataFormFatherNameLabel,
        //   placeholder: RegisterLabels.personalDataFormFatherNamePlaceholder,
        //   controller: fatherNameController,
        //   textCapitalization: TextCapitalization.words,
        //   textInputAction: TextInputAction.next,
        //   focusNode: fatherNameFocus,
        //   onSubmitted: (String input) {
        //     Helpers.changeFocus(context, fatherNameFocus, phoneFocus);
        //   },
        //   onChange: (String? input) {
        //     store.state.individualPerson!.fatherName = input ?? '';
        //     store.updateForm(store.state);
        //   },
        // ),
        // const SizedBox(height: 15),
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
            store.updateForm(store.state);
          },
        ),
        const SizedBox(height: 15),
        // SelectFieldWidget<EthnicityType>(
        //   label: RegisterLabels.personalDataFormEthnicityLabel,
        //   items: EthnicityType.values,
        //   itemsLabels: EthnicityType.values.map((type) => type.label).toList(),
        //   placeholder: RegisterLabels.personalDataFormEthnicityPlaceholder,
        //   controller: ethnicityController,
        //   focusNode: ethnicityFocus,
        //   onSelectItem: (EthnicityType type) {
        //     ethnicityController.text = type.label;
        //     store.state.individualPerson!.ethnicity = type;
        //     store.updateForm(store.state);
        //     Helpers.changeFocus(context, ethnicityFocus, genreFocus);
        //   },
        // ),
        // const SizedBox(height: 15),
        // SelectFieldWidget<GenreType>(
        //   label: RegisterLabels.personalDataFormGenreLabel,
        //   items: GenreType.values,
        //   itemsLabels: GenreType.values.map((type) => type.label).toList(),
        //   placeholder: RegisterLabels.personalDataFormGenrePlaceholder,
        //   controller: genreController,
        //   focusNode: genreFocus,
        //   onSelectItem: (GenreType type) {
        //     genreController.text = type.label;
        //     store.state.individualPerson!.genre = type;
        //     store.updateForm(store.state);
        //     Helpers.changeFocus(context, genreFocus, bloodTypeFocus);
        //   },
        // ),
        // const SizedBox(height: 15),
        //Tipo sanguineo
        // SelectFieldWidget<BloodType>(
        //   label: RegisterLabels.personalDataFormBloodTypeLabel,
        //   items: BloodType.values,
        //   itemsLabels: BloodType.values.map((type) => type.label).toList(),
        //   placeholder: RegisterLabels.personalDataFormGenreBloodTypePlaceholder,
        //   controller: bloodTypeController,
        //   focusNode: bloodTypeFocus,
        //   onSelectItem: (BloodType type) {
        //     bloodTypeController.text = type.label;
        //     store.state.individualPerson!.bloodType = type;
        //     store.updateForm(store.state);
        //     FocusScope.of(context).requestFocus(FocusNode());
        //   },
        // ),
        // const SizedBox(height: 15),
        if (store.isUnderage()) const ResponsableDataFormWidget(),
      ],
    );
  }
}
