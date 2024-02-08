import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawer_labels/labels.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/drawer/stores/drawer_store.dart';
import 'package:omni_core/src/app/shared/easter_eggs/eggs_change_env_widget.dart';
import 'package:omni_core/src/app/shared/easter_eggs/eggs_request_password_widget.dart';
import 'package:omni_general/omni_general.dart';

class DrawerHeaderWidget extends StatefulWidget {
  const DrawerHeaderWidget({Key? key}) : super(key: key);

  @override
  _DrawerHeaderWidgetState createState() => _DrawerHeaderWidgetState();
}

class _DrawerHeaderWidgetState extends State<DrawerHeaderWidget> {
  String environmentPass = '';
  final DrawerStore store = Modular.get();
  final UserStore userStore = Modular.get<UserStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.2,
        //   child: Stack(
        //     fit: StackFit.expand,
        //     children: [
        //       Column(
        //         children: [
        //           Expanded(
        //             child: ColoredBox(
        //               color: Theme.of(context).primaryColor,
        //             ),
        //           ),
        //           const Expanded(child: SizedBox()),
        //         ],
        //       ),
        //       GestureDetector(
        //         child: Center(
        //           child: ClipOval(
        //             child: Container(
        //               color: Colors.transparent,
        //               padding: const EdgeInsets.all(5),
        //               child: ClipOval(child: _buildUserAvatar),
        //             ),
        //           ),
        //         ),
        //       ),
        //       Positioned(
        //         left: 15,
        //         top: MediaQuery.of(context).size.height * 0.025,
        //         child: GestureDetector(
        //           onTap: () => Modular.to.pop(context),
        //           child: Container(
        //             padding: const EdgeInsets.all(25),
        //             child: SvgPicture.asset(
        //               Assets.arrowLeft,
        //               package: AssetsPackage.omniGeneral,
        //               color: Theme.of(context).primaryColor,
        //               width: 25,
        //               height: 25,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15),
        //   child: _buildUserDataWidget,
        // )
      ],
    );
  }

  // Widget get _buildUserAvatar {
  //   return GestureDetector(
  //     onTap: () async {
  //       await FirebaseFirestore.instance
  //           .collection('environmentPass')
  //           .doc('environmentPass')
  //           .get()
  //           .then(
  //         (value) {
  //           environmentPass = value.data()!['key'];
  //         },
  //       );
  //       final key = encrypt.Key.fromLength(32);
  //       final iv = encrypt.IV.fromLength(16);

  //       final encrypter = encrypt.Encrypter(encrypt.AES(key));

  //       final decryptedEnvironmentPass =
  //           encrypter.decrypt64(environmentPass, iv: iv);

  //       if (store.state > 10) return;
  //       store.onChangeEnv();
  //       if (store.state == 6) {
  //         // ignore: use_build_context_synchronously
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             elevation: 0,
  //             behavior: SnackBarBehavior.floating,
  //             duration: const Duration(milliseconds: 5000),
  //             // ignore: use_build_context_synchronously
  //             backgroundColor: Theme.of(context).primaryColor,
  //             content: ScopedBuilder<DrawerStore, Exception, int>(
  //               store: store,
  //               onState: (_, state) {
  //                 return Text(
  //                   '${DrawerLabels.drawerHeaderEasterEggPress} ${10 - state} '
  //                   '${10 - state == 1 ? DrawerLabels.drawerHeaderEasterEggTime : DrawerLabels.drawerHeaderEasterEggTimes} '
  //                   '${DrawerLabels.drawerHeaderEasterEggChangeEnv}',
  //                   textAlign: TextAlign.center,
  //                   style: Theme.of(context).textTheme.titleLarge!.copyWith(
  //                         color: Colors.white,
  //                       ),
  //                 );
  //               },
  //             ),
  //           ),
  //         );
  //       } else if (store.state == 10) {
  //         // ignore: use_build_context_synchronously
  //         ScaffoldMessenger.of(context).clearSnackBars();

  //         // ignore: use_build_context_synchronously
  //         await showModalBottomSheet(
  //           context: context,
  //           enableDrag: false,
  //           isScrollControlled: true,
  //           isDismissible: false,
  //           clipBehavior: Clip.antiAliasWithSaveLayer,
  //           backgroundColor: Colors.transparent,
  //           shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(10),
  //               topRight: Radius.circular(10),
  //             ),
  //           ),
  //           builder: (_) => EggsRequestPasswordWidget(
  //             environmentPassword: decryptedEnvironmentPass,
  //           ),
  //         ).then(
  //           (isAdmin) {
  //             if (isAdmin == null || !isAdmin) return;
  //             Helpers.showDialog(context, const EggsChangeEnvWidget());
  //           },
  //         );
  //       }
  //     },
  //     child: ColoredBox(
  //       color: Colors.grey.withOpacity(0.1),
  //       child: TripleBuilder<UserStore, Exception, PreferencesModel>(
  //         store: userStore,
  //         builder: (_, triple) {
  //           return AbsorbPointer(
  //             child: ImageWidget(
  //               url: triple.state.beneficiary!.individualPerson!.image ?? '',
  //               asset: Assets.user,
  //               assetBase: Assets.userBase,
  //               boxFit: BoxFit.cover,
  //               package: AssetsPackage.omniGeneral,
  //               width: 100,
  //               height: 100,
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  // Widget get _buildUserDataWidget {
  //   return TripleBuilder<UserStore, Exception, PreferencesModel>(
  //     store: userStore,
  //     builder: (_, triple) {
  //       final String age = Helpers.getAge(
  //         triple.state.beneficiary!.individualPerson!.birth!,
  //       );
  //       final String label = int.tryParse(age) == 1
  //           ? DrawerLabels.drawerHeaderYear
  //           : DrawerLabels.drawerHeaderYears;
  //       return Column(
  //         children: [
  //           Text(
  //             Helpers.getShortName(
  //               triple.state.beneficiary!.individualPerson!.name.toString(),
  //             ),
  //             textAlign: TextAlign.center,
  //             style: Theme.of(context).textTheme.headlineMedium!.copyWith(
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //           ),
  //           const SizedBox(height: 15),
  //           Text(
  //             '$age $label',
  //             textAlign: TextAlign.center,
  //             style: Theme.of(context).textTheme.titleLarge!.copyWith(
  //                   fontWeight: FontWeight.w300,
  //                 ),
  //           ),
  //           const SizedBox(height: 10),
  //           const Divider(height: 0),
  //         ],
  //       );
  //     },
  //   );
  // }
}
