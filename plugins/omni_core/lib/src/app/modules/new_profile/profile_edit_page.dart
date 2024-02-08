import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/register/pages/widgets/birth_date_dialog.dart';
import 'package:omni_core/src/app/modules/new_profile/widgets/address_form.dart';
import 'package:omni_core/src/app/modules/profile/profile_store.dart';
import 'package:omni_core/src/app/modules/profile/widgets/profile_image_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:intl/intl.dart';

class ProfileEditPage extends StatefulWidget {
  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emergencyPhoneController = TextEditingController();
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
    store.updateProfile(store.userStore.state.user!.individualPerson!);
    nameController.text = store.state.name ?? '';
    final dataNascimento = DateTime.parse(store.state.birth!);
    birthController.text = Formaters.dateToStringDate(dataNascimento);
    phoneController.text = store.state.phone ?? '';
    emergencyPhoneController.text = store.state.emergencyContact ?? '';
    streetController.text = store.state.address?.street ?? '';
    maritalStatusController.text = store.state.maritalStatus?.label ?? '';
    heightController.text = store.state.height != null ? store.state.height.toString() : '0.0';
    weightController.text = store.state.weight != null ? store.state.weight.toString() : '0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width > 500 ? 500 : 375;

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
        title: Center(
          child: Text(
            'Meu perfil',
            style: TextStyle(
              fontSize: 18 * fem,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20 * fem),
          child:
              // TripleBuilder(
              //   store: store,
              //   builder: (_, triple) {
              //     return
              Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ProfileImageWidget(),
              SizedBox(height: 24 * fem),
              TextFieldWidget(
                label: 'Nome completo',
                controller: nameController,
                // focusNode: usernameFocus,
                focusedborder: InputBorder.none,
                padding: EdgeInsets.zero,
                fem: fem,
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
                onTap: chooseBirthDate, fem: fem,
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
                fem: fem,
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
              const AddressForm(),

              const SizedBox(height: 12),
              SelectFieldWidget<MaritalStatus>(
                label: 'Estado civil',
                items: MaritalStatus.values,
                itemsLabels: MaritalStatus.values.map((type) => type.label!).toList(),
                placeholder: 'Estado civil',
                controller: maritalStatusController,
                // focusNode: genreFocus,
                fem: fem,
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
                fem: fem,
                onChange: (String? input) {
                  store.state.height = int.parse(input ?? '');
                  store.updateProfile(store.state);
                },
              ),

              const SizedBox(height: 12),
              TextFieldWidget(
                label: 'Peso (kg)',
                controller: weightController,
                // focusNode: usernameFocus,
                focusedborder: InputBorder.none,
                padding: EdgeInsets.zero, fem: fem,
                onChange: (String? input) {
                  store.state.weight = double.parse(input ?? '');
                  store.updateProfile(store.state);
                },
              ),

              // const SizedBox(height: 12),
              // TextFieldWidget(
              //   label: 'Contato de emergência',
              //   controller: emergencyPhoneController,
              //   // focusNode: usernameFocus,
              //   focusedborder: InputBorder.none,
              //   mask: Masks.generateMask('(##) # ####-####'),
              //   padding: EdgeInsets.zero,
              //   onChange: (String? input) {
              //     input = input!.replaceAll('(', '');
              //     input = input.replaceAll(')', '');
              //     input = input.replaceAll('-', '');
              //     input = input.replaceAll(' ', '');
              //     store.state.emergencyContact = input;
              //     store.updateProfile(store.state);
              //   },
              // ),
              SizedBox(height: 24 * fem),
              TextButton(
                onPressed: () async {
                  final data = store.state.toJson();
                  data.remove('usuario');
                  await store.updateNewProfile().then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          'Perfil atualizado!',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                    Modular.to.pop();
                  });
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Container(
                  height: 56 * fem,
                  decoration: BoxDecoration(
                    color: Color(0xff2d72b3),
                    borderRadius: BorderRadius.circular(60 * fem),
                  ),
                  child: TripleBuilder<ProfileStore, DioError, IndividualPersonModel>(
                    store: store,
                    builder: (_, triple) {
                      if (triple.isLoading) {
                        return const LoadingWidget(
                          indicatorColor: Colors.white,
                        );
                      }
                      return Center(
                        child: Text(
                          'Salvar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16 * fem,
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
