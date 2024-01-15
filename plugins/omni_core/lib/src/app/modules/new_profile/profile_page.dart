import 'package:drawer_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/app_stores/program_store.dart';
import 'package:omni_core/src/app/modules/new_profile/widgets/menu_option.dart';
import 'package:omni_core/src/app/modules/profile/profile_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage();

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileStore store = Modular.get();
  final ProgramStore programStore = Modular.get();

  Widget _buildExitWidget(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                Assets.exitOne,
                package: AssetsPackage.omniGeneral,
                height: 150,
                width: 100,
              ),
              SvgPicture.asset(
                Assets.exitTwo,
                package: AssetsPackage.omniGeneral,
                color: Theme.of(context).primaryColor,
                height: 150,
                width: 100,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            DrawerLabels.drawerWantLeave,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: DefaultButtonWidget(
                  onPressed: () => Navigator.pop(context),
                  text: DrawerLabels.drawerCancel,
                  buttonType: DefaultButtonType.outline,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: DefaultButtonWidget(
                  onPressed: () => LogoutService.logout(),
                  text: DrawerLabels.drawerShut,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    store.updateProfile(store.userStore.state.beneficiary!.individualPerson!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width > 500 ? 500 : 375;

    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20 * fem),
          child: SizedBox(
            width: double.infinity,
            child: Container(
              // medicalcardE6T (5103:24862)
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Modular.to.pushNamed('/newHome/profile/editProfile');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'Perfil',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.5 * ffem / fem,
                          color: const Color(0xff2d72b3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    // autogroupww4t87H (MYpjwXeaG2oAtk6eU5Ww4T)
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TripleBuilder<UserStore, Exception, PreferencesModel>(
                          store: store.userStore,
                          builder: (_, triple) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    child: ClipOval(
                                      child: ImageWidget(
                                        key: ValueKey(
                                          triple.state.beneficiary!.individualPerson,
                                        ),
                                        url: triple.state.beneficiary!.individualPerson!.image ?? '',
                                        asset: Assets.user,
                                        assetBase: Assets.userBase,
                                        boxFit: BoxFit.cover,
                                        width: 125 * fem,
                                        height: 125 * fem,
                                      ),
                                    )),
                                const SizedBox(height: 12),
                                SizedBox(
                                  // frame552puD (5103:24869)
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Text(
                                        // joanafonsecayGK (5103:24870)
                                        store.state.name ?? '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2999999306 * ffem / fem,
                                          color: const Color(0xff1a1c22),
                                        ),
                                      ),
                                      Text(
                                        // yearsoldhCK (5103:24871)
                                        '${Helpers.getAge(store.state.birth!)} anos de idade',
                                        // '33 anos de idade',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.6000000238 * ffem / fem,
                                          color: const Color(0xff52576a),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 20 * fem,
                        ),
                        // Card(
                        //   color: const Color(0xffF6F6F8),
                        //   surfaceTintColor: const Color(0xffF6F6F8),
                        //   elevation: 0,
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 16),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.end,
                        //       children: [
                        //         // MenuOption(
                        //         //   leadingIcon: const Icon(
                        //         //     Icons.add,
                        //         //     color: Colors.black,
                        //         //   ),
                        //         //   title: 'Diagnóstico',
                        //         //   onTap: () => Modular.to.pushNamed('/newHome/profile/diagnosis'),
                        //         // ),
                        //         const MenuOption(
                        //           leadingIcon: Icon(
                        //             Icons.create_new_folder_outlined,
                        //             color: Colors.black,
                        //           ),
                        //           title: 'Prescrições',
                        //         ),
                        //         const MenuOption(
                        //           leadingIcon: Icon(
                        //             Icons.featured_play_list_outlined,
                        //             color: Colors.black,
                        //           ),
                        //           title: 'Notas médicas',
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Card(
                          color: const Color(0xffF6F6F8),
                          surfaceTintColor: const Color(0xffF6F6F8),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // MenuOption(
                                //   leadingIcon: const Icon(
                                //     Icons.settings,
                                //     color: Colors.black,
                                //   ),
                                //   title: 'Configurações',
                                //   onTap: () => Modular.to.pushNamed('/newHome/profile/settings'),
                                // ),
                                MenuOption(
                                  leadingIcon: const Icon(
                                    Icons.list_alt_outlined,
                                    color: Colors.black,
                                  ),
                                  fem: fem,
                                  title: 'Termos e condições',
                                  onTap: () => Modular.to.pushNamed(
                                    '/terms',
                                    arguments: programStore.programSelected.code,
                                  ),
                                ),
                                MenuOption(
                                  leadingIcon: const Icon(
                                    Icons.logout,
                                    color: Colors.black,
                                  ),
                                  fem: fem,
                                  title: 'Configurações',
                                  onTap: () => Modular.to.pushNamed('/newHome/profile/settings/'),
                                ),
                                MenuOption(
                                  leadingIcon: const Icon(
                                    Icons.help_outline,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                  fem: fem,
                                  title: 'Centro de ajuda',
                                  onTap: () => launchUrl(Uri.parse('https://wa.me/5562982167570'),
                                      mode: LaunchMode.externalApplication),
                                ),
                                MenuOption(
                                  leadingIcon: const Icon(
                                    Icons.logout,
                                    color: Colors.black,
                                  ),
                                  fem: fem,
                                  title: 'Sair',
                                  onTap: () => Helpers.showDialog(
                                    context,
                                    _buildExitWidget(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20 * fem,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
