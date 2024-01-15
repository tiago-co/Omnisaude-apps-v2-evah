import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/register/pages/widgets/birth_date_dialog.dart';
import 'package:omni_auth/src/modules/register/stores/register_store.dart';
import 'package:omni_auth/src/modules/sign_up/sign_up/widgets/address_form.dart';
import 'package:omni_auth/src/modules/sign_up/widgets/welcome_form_field.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_register_labels/labels.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  final RegisterStore store = Modular.get();

  chooseBirthDate(BuildContext context) {
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
        store.state.individualPerson!.birth = Formaters.dateToStringDateWithHifen(birth);

        store.updateForm(store.state);
      },
    ).whenComplete(() => FocusScope.of(context).requestFocus(FocusNode()));
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final args = Modular.args;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 42,
            color: Colors.black54,
          ),
          onPressed: () {
            Modular.to.pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // pleasefillinallfieldstocomplet (4511:30507)
                  margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),

                  child: Text(
                    'Por favor preencha todos os campos para concluir a inscrição',
                    style: TextStyle(
                      fontSize: 22 * ffem,
                      fontWeight: FontWeight.w600,
                      height: 1.2999999306 * ffem / fem,
                      color: const Color(0xff1a1c22),
                    ),
                  ),
                ),
                Container(
                  // autogroupga3rDM1 (MYmNg4BKgKm5iLVNgHGA3R)
                  padding: EdgeInsets.fromLTRB(0 * fem, 28 * fem, 1 * fem, 7 * fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // frame3ioZ (4511:30508)
                        margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 4 * fem),
                        width: double.infinity,

                        child: Column(
                          children: [
                            // TextFieldWidget(
                            //   label: 'Nome completo',
                            //   controller: nameController,
                            //   // focusNode: usernameFocus,
                            //   focusedborder: InputBorder.none,
                            //   padding: EdgeInsets.zero,
                            //   onChange: (String? input) {
                            //     store.state.individualPerson?.name = input;
                            //     store.updateForm(store.state);
                            //   },
                            // ),
                            // const SizedBox(height: 12),
                            TextFieldWidget(
                              label: 'Data de Nascimento',
                              controller: birthController,
                              // focusNode: usernameFocus,
                              onTap: () {
                                chooseBirthDate(context);
                              },
                              readOnly: true,
                              focusedborder: InputBorder.none,
                              padding: EdgeInsets.zero,
                              suffixIcon: Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.grey,
                              ),
                              fem: fem,
                              onChange: (String? input) {
                                store.state.individualPerson?.birth = input;
                                store.updateForm(store.state);
                              },
                            ),
                            // const WelcomeFormField(label: 'Data de nascimento'),
                            const SizedBox(height: 12),
                            TextFieldWidget(
                              label: 'Telefone',
                              controller: phoneController,
                              mask: Masks.generateMask('(##) # ####-####'),
                              // focusNode: usernameFocus,
                              focusedborder: InputBorder.none,
                              padding: EdgeInsets.zero, fem: fem,
                              onChange: (String? input) {
                                input = input!.replaceAll('(', '');
                                input = input.replaceAll(')', '');
                                input = input.replaceAll('-', '');
                                input = input.replaceAll(' ', '');
                                store.state.individualPerson?.phone = input;
                                store.updateForm(store.state);
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
                              controller: maritalStatusController, fem: fem,
                              // focusNode: genreFocus,
                              onSelectItem: (MaritalStatus type) {
                                maritalStatusController.text = type.label!;
                                store.state.individualPerson!.maritalStatus = type;
                                store.updateForm(store.state);
                                // Helpers.changeFocus(context, genreFocus, bloodTypeFocus);
                              },
                            ),

                            const SizedBox(height: 12),
                            TextFieldWidget(
                              label: 'Altura (cm)',
                              controller: heightController,
                              keyboardType: TextInputType.number,
                              focusedborder: InputBorder.none,
                              padding: EdgeInsets.zero,
                              fem: fem,
                              onChange: (String? input) {
                                store.state.individualPerson?.height = int.parse(input ?? '');
                                store.updateForm(store.state);
                              },
                            ),

                            const SizedBox(height: 12),
                            TextFieldWidget(
                              label: 'Peso (kg)',
                              controller: weightController,
                              keyboardType: TextInputType.number,
                              focusedborder: InputBorder.none,
                              padding: EdgeInsets.zero,
                              fem: fem,
                              onChange: (String? input) {
                                store.state.individualPerson?.weight = double.parse(input ?? '');
                                store.updateForm(store.state);
                              },
                            ),

                            // const SizedBox(height: 12),
                            // const WelcomeFormField(label: 'Contato de emergência'),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await store
                              .updateUser(
                            pass: args.data?['password'],
                            prefs: args.data?['data'],
                          )
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  "$value",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                            Modular.to.pushReplacementNamed('/newHome');
                          }).catchError((onError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  "${onError.message}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                            // Helpers.showDialog(
                            //   context,
                            //   RequestErrorWidget(
                            //     error: onError,
                            //     buttonText: RegisterLabels.close,
                            //     onPressed: () => Modular.to.pop(),
                            //   ),
                            //   showClose: true,
                            // );
                          });
                        },
                        child: Container(
                          // masterbuttonmaster82s (I4511:30472;19:7770)
                          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(0 * fem, 16 * fem, 0 * fem, 16 * fem),

                          height: 56 * fem,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: true ? Color(0xff2D73B3) : Color(0xff2d72b3),
                            borderRadius: BorderRadius.circular(60 * fem),
                          ),
                          child: Container(
                            // autogroupfwxxDa7 (MYmMmLCB3rKy918MJrfWxX)
                            padding: EdgeInsets.fromLTRB(13 * fem, 0 * fem, 0 * fem, 0 * fem),
                            child: TripleBuilder(
                              store: store,
                              builder: (context, triple) {
                                if (triple.isLoading) {
                                  return const LoadingWidget(
                                    indicatorColor: Colors.white,
                                  );
                                }
                                return Text(
                                  'Completar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
