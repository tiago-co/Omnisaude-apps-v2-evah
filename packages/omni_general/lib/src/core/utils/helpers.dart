import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_general/src/core/enums/biometric_type_enum.dart';

class Helpers {
  static Future<void> showDialog(
    BuildContext context,
    Widget child, {
    bool showClose = false,
  }) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (_, animation, secondaryAnimation) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showClose)
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: SvgPicture.asset(
                        Assets.close,
                        package: AssetsPackage.omniGeneral,
                        color: Colors.white,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                ),
              Flexible(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).cardColor,
                      width: 0.05,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: -5,
                        color: Theme.of(context).cardColor.withOpacity(0.5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      color: Colors.transparent,
                      child: child,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void copyText(BuildContext context, String? text) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    Clipboard.setData(ClipboardData(text: text!)).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 1500),
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Text(
            'Texto copiado para sua área de transferência',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      );
    });
  }

  static String getShortName(String fullName) {
    final List<String> nameSplited = fullName.split(' ');
    if (nameSplited.length == 1) return nameSplited.first;
    return '${nameSplited.first} ${nameSplited.last}';
  }

  static void changeFocus(BuildContext _, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(_).requestFocus(next);
  }

  static bool cpfIsValid(String cpf) {
    final String numeros = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    if (numeros.length != 11) return false;
    if (RegExp(r'^(\d)\1*$').hasMatch(numeros)) return false;
    final List<int> digitos = numeros
        .split('')
        .map(
          (String d) => int.parse(d),
        )
        .toList();
    var calcDv1 = 0;
    for (final i in Iterable<int>.generate(9, (i) => 10 - i)) {
      calcDv1 += digitos[10 - i] * i;
    }
    calcDv1 %= 11;
    final dv1 = calcDv1 < 2 ? 0 : 11 - calcDv1;
    if (digitos[9] != dv1) return false;
    int calcDv2 = 0;
    for (final i in Iterable<int>.generate(10, (i) => 11 - i)) {
      calcDv2 += digitos[11 - i] * i;
    }
    calcDv2 %= 11;
    final dv2 = calcDv2 < 2 ? 0 : 11 - calcDv2;
    if (digitos[10] != dv2) return false;
    return true;
  }

  static Future<bool> checkDevicebluetoothIsOn() async {
    return FlutterBluePlus.isOn;
  }

  static String getAge(String date) {
    final DateTime birth = DateFormat('yyyy-MM-dd').parse(date);
    int age;

    final DateTime now = DateTime.now();
    final int year = birth.year;
    final int month = birth.month;
    final int day = birth.day;

    final int difYear = now.year - year;
    final int difMonth = now.month - month;
    final int difDay = now.day - day;

    age = difYear;
    if (difMonth < 0) {
      age = difYear - 1;
    } else if (difMonth == 0) {
      age = difYear;
      if (difDay < 0) {
        age = difYear - 1;
      }
    }
    return age.toString();
  }

  static bool isEmail(String email) {
    const String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final RegExp regExp = RegExp(p);
    return regExp.hasMatch(email);
  }

  static Widget activateBiometricAuth(
    BuildContext context,
    VoidCallback login,
    BiometricTypeEnum biometricType,
  ) {
    final PreferencesService preferencesService = PreferencesService();
    final UseBiometricsStore useBiometricsStore = Modular.get();

    Future<void> setBiometricUsage(UseBiometricPermission value) async {
      preferencesService.setHasBiometrics(value);
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          if (Platform.isIOS)
            SvgPicture.asset(
              biometricType.iOSAsset,
              package: AssetsPackage.omniGeneral,
              color: Theme.of(context).primaryColor,
              height: 100,
              width: 100,
            )
          else if (Platform.isAndroid)
            SvgPicture.asset(
              biometricType.iOSAsset,
              package: AssetsPackage.omniGeneral,
              color: Theme.of(context).primaryColor,
              height: 100,
              width: 100,
            )
          else
            SvgPicture.asset(
              Assets.fingerprint,
              package: AssetsPackage.omniGeneral,
              color: Theme.of(context).primaryColor,
              height: 100,
              width: 100,
            ),
          const SizedBox(height: 15),
          Text(
            'Deixe sua conta mais segura',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 15),
          Text(
            'Use o método de desbloqueio do seu celular sempre que quiser abrir o aplicativo e realizar atividades',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: DefaultButtonWidget(
                  onPressed: () async {
                    useBiometricsStore.updateState(
                      UseBiometricPermission.denied,
                    );
                    await setBiometricUsage(UseBiometricPermission.denied).then(
                      (value) {
                        Navigator.of(context).pop();
                        login.call();
                      },
                    );
                  },
                  text: 'Agora não',
                  buttonType: DefaultButtonType.outline,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: DefaultButtonWidget(
                  onPressed: () async {
                    useBiometricsStore.updateState(
                      UseBiometricPermission.accepted,
                    );

                    await setBiometricUsage(
                      UseBiometricPermission.accepted,
                    ).then(
                      (value) {
                        Navigator.of(context).pop();
                        login.call();
                      },
                    );
                  },
                  text: 'Ativar',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  static Color getBackgroundColor(num discount) {
    if (discount <= 30) {
      return const Color(0xffF2F8FD);
    } else if (discount <= 40) {
      return const Color(0xffFDF4EC);
    } else {
      return const Color(0xffFDF2F2);
    }
  }

  static Color getTextColor(num discount) {
    if (discount <= 30) {
      return const Color(0xff2D73B3);
    } else if (discount <= 40) {
      return const Color(0xffFCA364);
    } else {
      return const Color(0xffED8282);
    }
  }
}
