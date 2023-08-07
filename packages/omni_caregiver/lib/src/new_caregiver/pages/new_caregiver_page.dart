import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_caregiver/omni_caregiver.dart';
import 'package:omni_caregiver/src/new_caregiver/new_caregiver_store.dart';
import 'package:omni_caregiver/src/new_caregiver/pages/new_caregiver_success_page.dart';
import 'package:omni_caregiver/src/new_caregiver/pages/widget/new_caregiver_form_widget.dart';
import 'package:omni_caregiver_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class NewCaregiverPage extends StatefulWidget {
  final String moduleName;

  const NewCaregiverPage({
    Key? key,
    required this.moduleName,
  }) : super(key: key);

  @override
  _NewCaregiverPageState createState() => _NewCaregiverPageState();
}

class _NewCaregiverPageState extends State<NewCaregiverPage> {
  final NewCaregiverStore store = Modular.get();
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController();

  @override
  void dispose() {
    scrollController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.moduleName).build(context) as AppBar,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(15),
              physics: const BouncingScrollPhysics(),
              child: TripleBuilder(
                store: store,
                builder: (_, triple) {
                  return AbsorbPointer(
                    absorbing: triple.isLoading,
                    child: Opacity(
                      opacity: triple.isLoading ? 0.5 : 1.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const NewCaregiverFormWidget(),
                          const SizedBox(height: 15),
                          TripleBuilder(
                            store: store,
                            builder: (_, triple) {
                              return NotificationsSettingsWidget(
                                changeSmsValue: store.onChangeSMSCheck,
                                smsCheckValue: store.smsCheck,
                                changeEmailValue: store.onChangeEmailCheck,
                                emailCheckValue: store.emailCheck,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const NewCaregiverSuccessPage(),
        ],
      ),
      bottomNavigationBar:
          TripleBuilder<NewCaregiverStore, DioError, CaregiverModel>(
        store: store,
        builder: (_, triple) {
          return BottomButtonWidget(
            onPressed: () {
              if (store.activePage == 0) {
                FocusScope.of(context).requestFocus(FocusNode());
                scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate,
                );
                store.createCaregiver(triple.state).then((value) {
                  pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                  );
                }).catchError((onError) {
                  Helpers.showDialog(
                    context,
                    RequestErrorWidget(
                      error: onError,
                      onPressed: () => Modular.to.pop(),
                      buttonText: CaregiverLabels.close,
                    ),
                    showClose: true,
                  );
                });
              } else {
                Modular.to.pushReplacementNamed(
                  '/home/caregivers/caregiverDetails/',
                  arguments: triple.state,
                );
              }
            },
            isDisabled: store.isDisabled(),
            isLoading: triple.isLoading,
            buttonType: BottomButtonType.outline,
            text: store.activePage == 1
                ? CaregiverLabels.newCaregiverSeeCaregiver
                : CaregiverLabels.newCaregiverAddCaregiver,
          );
        },
      ),
    );
  }
}
