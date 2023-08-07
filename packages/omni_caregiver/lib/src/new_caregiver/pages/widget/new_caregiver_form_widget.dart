import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_caregiver/omni_caregiver.dart';
import 'package:omni_caregiver/src/new_caregiver/new_caregiver_store.dart';
import 'package:omni_caregiver_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class NewCaregiverFormWidget extends StatefulWidget {
  const NewCaregiverFormWidget({Key? key}) : super(key: key);

  @override
  _NewCaregiverFormWidgetState createState() => _NewCaregiverFormWidgetState();
}

class _NewCaregiverFormWidgetState extends State<NewCaregiverFormWidget> {
  final NewCaregiverStore store = Modular.get();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode cpfFocus = FocusNode();
  final List<FocusNode> phonesFocus = [FocusNode()];
  final List<FocusNode> emailsFocus = [FocusNode()];
  final List<TextEditingController> phonesController = [
    TextEditingController()
  ];
  final List<TextEditingController> emailsController = [
    TextEditingController()
  ];

  @override
  void dispose() {
    nameController.dispose();
    cpfController.dispose();
    phonesController.forEach((controller) {
      controller.dispose();
    });
    emailsController.forEach((controller) {
      controller.dispose();
    });
    phonesFocus.forEach((focus) {
      focus.dispose();
    });
    emailsFocus.forEach((focus) {
      focus.dispose();
    });
    super.dispose();
  }

  void addOrRemovePhone(int phone) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (phone == 0) {
      phonesController.add(TextEditingController());
      phonesFocus.add(FocusNode());
      store.addPhone();
    } else {
      store.removePhone();
      phonesController.removeLast();
    }
  }

  void addOrRemoveEmail(int email) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (email == 0) {
      emailsController.add(TextEditingController());
      emailsFocus.add(FocusNode());
      store.addEmail();
    } else {
      store.removeEmail();
      emailsController.removeLast();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFieldWidget(
            label: CaregiverLabels.newCaregiverNameLabel,
            placeholder: CaregiverLabels.newCaregiverNamePlaceholder,
            controller: nameController,
            focusNode: nameFocus,
            textInputAction: TextInputAction.next,
            onSubmitted: (String input) {
              Helpers.changeFocus(context, nameFocus, cpfFocus);
            },
            textCapitalization: TextCapitalization.words,
            onChange: (String? input) {
              store.state.name = input;
              store.update(CaregiverModel.fromJson(store.state.toJson()));
            },
            prefixIcon: Icon(
              Icons.person_outline_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ),
          TextFieldWidget(
            label: CaregiverLabels.newCaregiverCPFLabel,
            placeholder: CaregiverLabels.newCaregiverCPFPlaceholder,
            mask: Masks().cpf,
            controller: cpfController,
            focusNode: cpfFocus,
            textInputAction: TextInputAction.next,
            onSubmitted: (String input) {
              Helpers.changeFocus(context, cpfFocus, phonesFocus[0]);
            },
            onChange: (String? input) {
              if (input == null) return;
              store.state.cpf = input.replaceAll(
                RegExp(r'[^0-9]'),
                '',
              );
              store.update(CaregiverModel.fromJson(store.state.toJson()));
            },
            prefixIcon: Icon(
              Icons.account_balance_wallet_outlined,
              color: Theme.of(context).primaryColor,
            ),
          ),
          _buildPhonesWidget,
          _buildEmailsWidget,
        ],
      ),
    );
  }

  Widget get _buildPhonesWidget {
    return TripleBuilder(
      store: store,
      builder: (_, triple) {
        return Column(
          children: store.phones.map((phone) {
            late final String label;
            if (phone == 0) {
              label = CaregiverLabels.primaryPhoneLabel;
            } else {
              label = '${CaregiverLabels.phoneLabel}${phone + 1}';
            }
            return TextFieldWidget(
              label: label,
              placeholder: CaregiverLabels.newCaregiverPhonePlaceholder,
              focusNode: phonesFocus[phone],
              controller: phonesController[phone],
              mask: Masks().phone,
              onSubmitted: (String input) {
                Helpers.changeFocus(
                  context,
                  phonesFocus[phone],
                  emailsFocus[0],
                );
              },
              onChange: (String? input) {
                if (input == null) return;
                store.state.phones![phone] = input.replaceAll(
                  RegExp(r'[^0-9]'),
                  '',
                );
                store.update(store.state);
              },
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              prefixIcon: Icon(
                Icons.phone_outlined,
                color: phone == 0
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
              ),
              suffixIcon: phone != 0 && phone != store.phones.length - 1
                  ? null
                  : Opacity(
                      opacity:
                          store.phones.length > 4 && phone == 0 ? 0.5 : 1.0,
                      child: GestureDetector(
                        onTap: store.phones.length > 4 && phone == 0
                            ? null
                            : () => addOrRemovePhone(phone),
                        child: Icon(
                          phone == 0 ? Icons.add : Icons.remove,
                          color: phone == 0
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor,
                        ),
                      ),
                    ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget get _buildEmailsWidget {
    return TripleBuilder(
      store: store,
      builder: (_, triple) {
        return Column(
          children: store.emails.map((email) {
            late final String label;
            if (email == 0) {
              label = CaregiverLabels.primaryEmailLabel;
            } else {
              label = '${CaregiverLabels.emailLabel} ${email + 1}';
            }
            return TextFieldWidget(
              label: label,
              textCapitalization: TextCapitalization.none,
              placeholder: CaregiverLabels.newCaregiverEmailPlaceholder,
              controller: emailsController[email],
              focusNode: emailsFocus[email],
              onSubmitted: (String input) {
                Helpers.changeFocus(
                  context,
                  phonesFocus[email],
                  FocusNode(),
                );
              },
              onChange: (String? input) {
                if (input == null) return;
                store.state.emails![email] = input;
                store.update(store.state);
              },
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icon(
                Icons.email_outlined,
                color: email == 0
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
              ),
              suffixIcon: email != 0 && email != store.emails.length - 1
                  ? null
                  : Opacity(
                      opacity:
                          store.emails.length > 4 && email == 0 ? 0.5 : 1.0,
                      child: GestureDetector(
                        onTap: store.emails.length > 4 && email == 0
                            ? null
                            : () => addOrRemoveEmail(email),
                        child: Icon(
                          email == 0 ? Icons.add : Icons.remove,
                          color: email == 0
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor,
                        ),
                      ),
                    ),
            );
          }).toList(),
        );
      },
    );
  }
}
