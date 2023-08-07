import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_caregiver/omni_caregiver.dart';
import 'package:omni_caregiver/src/caregiver_details/stores/caregiver_details_store.dart';
import 'package:omni_caregiver/src/caregiver_details/widgets/caregiver_field_info_widget.dart';
import 'package:omni_caregiver_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class CaregiverDetailsPage extends StatefulWidget {
  final CaregiverModel caregiver;

  const CaregiverDetailsPage({
    Key? key,
    required this.caregiver,
  }) : super(key: key);
  @override
  CaregiverDetailsPageState createState() => CaregiverDetailsPageState();
}

class CaregiverDetailsPageState extends State<CaregiverDetailsPage> {
  final CaregiverDetailsStore store = Modular.get();
  @override
  void initState() {
    store.state.cpf = widget.caregiver.cpf;
    store.state.id = widget.caregiver.id;
    store.state.name = widget.caregiver.name;
    store.state.phones = widget.caregiver.phones;
    store.state.sendEmail = widget.caregiver.sendEmail;
    store.state.sendSMS = widget.caregiver.sendSMS;
    store.state.emails = widget.caregiver.emails;
    store.smsCheck = widget.caregiver.sendSMS!;
    store.emailCheck = widget.caregiver.sendEmail!;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(
        title: Helpers.getShortName(store.state.name ?? '-'),
      ).build(context) as AppBar,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildCaregiverDetailsWidget,
                    const SizedBox(height: 15),
                    TripleBuilder(
                      store: store,
                      builder: (_, triple) {
                        return DefaultButtonWidget(
                          onPressed: () {
                            Helpers.showDialog(
                              context,
                              _buildRemoveCaregiverWidget,
                            );
                          },
                          text: CaregiverLabels.caregiverDetailsRemoveCaregiver,
                          isLoading: triple.isLoading,
                          isDisabled: triple.isLoading,
                          buttonType: DefaultButtonType.outline,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildCaregiverDetailsWidget {
    return TripleBuilder<CaregiverDetailsStore, DioError, CaregiverModel>(
      store: store,
      builder: (_, triple) {
        return IgnorePointer(
          ignoring: triple.isLoading,
          child: Opacity(
            opacity: triple.isLoading ? 0.5 : 1.0,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  CaregiverFieldInfoWidget(
                    label: CaregiverLabels.caregiverDetailsNameLabel,
                    value: triple.state.name,
                    onChangeField: (String input) => {'nome': input},
                  ),
                  CaregiverFieldInfoWidget(
                    label: CaregiverLabels.caregiverDetailsCPFLabel,
                    value: Formaters.formatCPF(triple.state.cpf ?? '-'),
                    readOnly: true,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: triple.state.phones!.map((phone) {
                      late String label;
                      if (phone == triple.state.phones!.first) {
                        label =
                            CaregiverLabels.primaryPhoneLabel;
                      } else {
                        label = '${CaregiverLabels.phoneLabel}'
                            '${triple.state.phones!.indexOf(phone) + 1}';
                      }
                      return CaregiverFieldInfoWidget(
                        label: label,
                        value: Formaters.formatPhone(phone),
                        mask: Masks().phone,
                        onChangeField: (String input) {
                          final int index = triple.state.phones!.indexOf(phone);
                          triple.state.phones![index] = input;
                          return {'telefones': triple.state.phones};
                        },
                      );
                    }).toList(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: triple.state.emails!.map((email) {
                      late String label;
                      if (email == triple.state.emails!.first) {
                        label =
                            CaregiverLabels.primaryEmailLabel;
                      } else {
                        label = '${CaregiverLabels.emailLabel} '
                            '${triple.state.emails!.indexOf(email) + 1}';
                      }
                      return CaregiverFieldInfoWidget(
                        label: label,
                        value: email,
                        onChangeField: (String input) {
                          if (formKey.currentState!.validate()) {
                            final int index =
                                triple.state.emails!.indexOf(email);
                            triple.state.emails![index] = input;
                            return {'emails': triple.state.emails};
                          } else {
                            return {'emails': triple.state.emails};
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 15),
                  NotificationsSettingsWidget(
                    changeSmsValue: store.onChangeSMSCheck,
                    smsCheckValue: store.smsCheck,
                    changeEmailValue: store.onChangeEmailCheck,
                    emailCheckValue: store.emailCheck,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget get _buildRemoveCaregiverWidget {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Text(
            CaregiverLabels.caregiverDetailsConfirmRemoveCaregiver,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: DefaultButtonWidget(
                  onPressed: () => Navigator.pop(context),
                  text: CaregiverLabels.caregiverDetailsCancel,
                  buttonType: DefaultButtonType.outline,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(primaryColor: Colors.red),
                  child: DefaultButtonWidget(
                    onPressed: () {
                      Modular.to.pop();
                      store
                          .removeCaregiverById(widget.caregiver.id!)
                          .then((value) async {
                        await Helpers.showDialog(
                          context,
                          SuccessWidget(
                            message:
                                CaregiverLabels.caregiverDetailsRemoveSuccess,
                            onPressed: () {
                              Modular.to.pop();
                            },
                          ),
                        );

                        Modular.to.pop();
                      }).catchError(
                        (onError) async {
                          Helpers.showDialog(
                            context,
                            RequestErrorWidget(
                              message:
                                  CaregiverLabels.caregiverDetailsRemoveError,
                              buttonText: CaregiverLabels.close,
                              onPressed: () {
                                Modular.to.pop();
                              },
                            ),
                          );
                        },
                      );
                    },
                    text: CaregiverLabels.caregiverDetailsRemove,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
