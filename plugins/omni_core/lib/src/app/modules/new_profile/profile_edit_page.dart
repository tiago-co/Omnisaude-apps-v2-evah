import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/register/pages/widgets/birth_date_dialog.dart';
import 'package:omni_core/src/app/modules/profile/profile_store.dart';
import 'package:omni_core/src/app/modules/profile/widgets/profile_image_widget.dart';
import 'package:omni_general/omni_general.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController jsonValueController = TextEditingController(text: '');

  final ProfileStore store = Modular.get();

  void chooseBirthDate() {
    // service
    //     .selectDate(
    //   context,
    //   enablePastDates: true,
    //   maxDate: DateTime.now(),
    //   minDate: DateTime(1900),
    //   initialDisplayDate: DateTime(
    //     DateTime.now().year,
    //     DateTime.now().month,
    //     DateTime.now().day,
    //   ),
    // )
    showDialog(
      context: context,
      builder: (context) => const BirthDateDialog(),
    ).then(
      (birth) {
        if (birth == null) return;

        birthController.text = Formaters.dateToStringDate(birth);
        store.state.birth = Formaters.dateToStringDateWithHifen(birth);

        store.updateProfile(store.state);
      },
    ).whenComplete(() => FocusScope.of(context).requestFocus(FocusNode()));
  }

  @override
  void initState() {
    store.updateProfile(store.userStore.state.beneficiary!.individualPerson!);
    nameController.text = store.state.name ?? '';
    birthController.text = store.state.birth ?? '';
    phoneController.text = store.state.phone ?? '';
    streetController.text = store.state.address?.street ?? '';
    maritalStatusController.text = store.state.maritalStatus?.label ?? '';
    heightController.text = store.state.height != null ? store.state.height.toString() : '0.0';
    weightController.text = store.state.weight != null ? store.state.weight.toString() : '0.0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Modular.to.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Center(
          child: Text(
            'Meu perfil',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child:
              // TripleBuilder(
              //   store: store,
              //   builder: (_, triple) {
              //     return
              Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ProfileImageWidget(),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Nome completo',
                controller: nameController,
                // focusNode: usernameFocus,
                focusedborder: InputBorder.none,
                padding: EdgeInsets.zero,
                onChange: (String? input) {
                  store.state.name = input;
                  store.updateProfile(store.state);
                },
              ),
              const SizedBox(height: 12),
              TextFieldWidget(
                label: 'Data de Nascimento',
                controller: birthController,
                // focusNode: usernameFocus,
                focusedborder: InputBorder.none,
                padding: EdgeInsets.zero,
                onTap: chooseBirthDate,
                onChange: (String? input) {
                  store.state.birth = input;
                  store.updateProfile(store.state);
                },
              ),
              // const WelcomeFormField(label: 'Data de nascimento'),
              const SizedBox(height: 12),
              TextFieldWidget(
                label: 'Telefone',
                controller: phoneController,
                focusedborder: InputBorder.none,
                mask: Masks.generateMask('(##) # ####-####'),
                padding: EdgeInsets.zero,
                onChange: (String? input) {
                  input = input!.replaceAll('(', '');
                  input = input.replaceAll(')', '');
                  input = input.replaceAll('-', '');
                  input = input.replaceAll(' ', '');
                  store.state.phone = input;
                  store.updateProfile(store.state);
                },
              ),
              const SizedBox(height: 12),
              TextFieldWidget(
                label: 'Endereço',
                controller: streetController,
                // focusNode: usernameFocus,
                focusedborder: InputBorder.none,
                padding: EdgeInsets.zero,
                onChange: (String? input) {
                  store.state.address?.street = input;
                  store.updateProfile(store.state);
                },
              ),
              const SizedBox(height: 12),
              SelectFieldWidget<MaritalStatus>(
                label: 'Estado civil',
                items: MaritalStatus.values,
                itemsLabels: MaritalStatus.values.map((type) => type.label!).toList(),
                placeholder: 'Estado civil',
                controller: maritalStatusController,
                // focusNode: genreFocus,
                onSelectItem: (MaritalStatus type) {
                  maritalStatusController.text = type.label!;
                  store.state.maritalStatus = type;
                  store.updateProfile(store.state);
                  // Helpers.changeFocus(context, genreFocus, bloodTypeFocus);
                },
              ),

              const SizedBox(height: 12),
              TextFieldWidget(
                label: 'Altura (cm)',
                controller: heightController,
                focusedborder: InputBorder.none,
                padding: EdgeInsets.zero,
                onChange: (String? input) {
                  store.state.height = double.parse(input ?? '');
                  store.updateProfile(store.state);
                },
              ),

              const SizedBox(height: 12),
              TextFieldWidget(
                label: 'Peso (kg)',
                controller: weightController,
                // focusNode: usernameFocus,
                focusedborder: InputBorder.none,
                padding: EdgeInsets.zero,
                onChange: (String? input) {
                  store.state.weight = double.parse(input ?? '');
                  store.updateProfile(store.state);
                },
              ),

              const SizedBox(height: 12),
              TextFieldWidget(
                label: 'Contato de emergência',
                controller: TextEditingController(),
                // focusNode: usernameFocus,
                focusedborder: InputBorder.none,
                padding: EdgeInsets.zero,
                onChange: (String? input) {
                  store.state.weight = double.parse(input ?? '');
                  store.updateProfile(store.state);
                },
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  final data = store.state.toJson();
                  data.remove('usuario');
                  store.updateField(data).then((value) => Modular.to.pop());
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff2d72b3),
                    borderRadius: BorderRadius.circular(60 * fem),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      'Save',
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
            ],
          ),
          //     ;
          //   },
          // ),
        ),
      ),
    );
  }
}
