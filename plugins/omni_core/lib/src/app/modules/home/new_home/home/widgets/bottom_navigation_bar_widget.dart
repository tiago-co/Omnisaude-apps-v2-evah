import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/modules/home/new_home/home/bottom_navigation_store.dart';
import 'package:omni_general/omni_general.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  BottomNavigationBarWidget();

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;
  final BottomNavigationStore _bottomNavigationStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    // double ffem = fem * 0.97;
    return TripleBuilder<BottomNavigationStore, Exception, int>(
        store: _bottomNavigationStore,
        builder: (_, triple) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffededf1)),
              color: Color(0xffffffff),
            ),
            child: BottomNavigationBar(
              // showUnselectedLabels: true,
              selectedFontSize: 12,
              selectedLabelStyle: const TextStyle(color: Color(0xff2d72b3)),
              unselectedLabelStyle: const TextStyle(color: Color(0xff2d72b3)),
              selectedItemColor: Color(0xff2d72b3),
              unselectedItemColor: Color(0xff2d72b3),
              type: BottomNavigationBarType.fixed,
              currentIndex: _bottomNavigationStore.state,

              onTap: (index) {
                _bottomNavigationStore.updatePage(index);
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    Assets.homeIcon,
                    package: AssetsPackage.omniCore,
                    width: 26 * fem,
                    height: 26 * fem,
                    color: const Color(0xff2d72b3),
                  ),
                  activeIcon: SvgPicture.asset(
                    Assets.homeFilledIcon,
                    package: AssetsPackage.omniCore,
                    width: 26 * fem,
                    height: 26 * fem,
                    color: const Color(0xff2d72b3),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    Assets.calendarIcon,
                    package: AssetsPackage.omniCore,
                    width: 26 * fem,
                    height: 26 * fem,
                    color: const Color(0xff2d72b3),
                  ),
                  activeIcon: SvgPicture.asset(
                    Assets.calendarFilledIcon,
                    package: AssetsPackage.omniCore,
                    width: 26 * fem,
                    height: 26 * fem,
                    color: const Color(0xff2d72b3),
                  ),
                  label: 'Lembretes',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    Assets.notesIcon,
                    package: AssetsPackage.omniCore,
                    width: 26 * fem,
                    height: 26 * fem,
                    color: const Color(0xff2d72b3),
                  ),
                  activeIcon: SvgPicture.asset(
                    Assets.notesFilledIcon,
                    package: AssetsPackage.omniCore,
                    width: 26 * fem,
                    height: 26 * fem,
                    color: const Color(0xff2d72b3),
                  ),
                  label: 'Notas',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    Assets.personIcon,
                    package: AssetsPackage.omniCore,
                    width: 26 * fem,
                    height: 26 * fem,
                    color: const Color(0xff2d72b3),
                  ),
                  activeIcon: SvgPicture.asset(
                    Assets.personFilledIcon,
                    package: AssetsPackage.omniCore,
                    width: 26 * fem,
                    height: 26 * fem,
                    color: const Color(0xff2d72b3),
                  ),
                  label: 'Perfil',
                ),
              ],
            ),
          );
        });
  }
}
