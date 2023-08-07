import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/bottom_nav_bar_enum.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/omniplan_module_icon_store.dart';
import 'package:omni_core/src/app/modules/home/pages/stores/unread_notifications_count_store.dart';

class HomeBottomNavBarWidget extends StatefulWidget {
  const HomeBottomNavBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeBottomNavBarWidget> createState() => _HomeBottomNavBarWidgetState();
}

class _HomeBottomNavBarWidgetState extends State<HomeBottomNavBarWidget> {
  final OmniplanModuleIconStore store = Modular.get();
  final UnreadNotificationsCountStore unreadNotificationStore = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const IconData baseball = IconData(
      0xff3dd,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage,
    );
    const Icon(baseball);
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: -5,
            color: Theme.of(context).cardColor,
          ),
        ],
        color: Colors.white,
      ),
      child: TripleBuilder<OmniplanModuleIconStore, Exception, bool>(
        store: store,
        builder: (_, triple) {
          return SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TripleBuilder(
                    store: unreadNotificationStore,
                    builder: (_, triple) {
                      return _buildNotificationIconWidget(
                        context,
                        BottomNavBarType.notification,
                      );
                    },
                  ),
                  _buildItemWidget(context, BottomNavBarType.drawer),
                  if (store.state)
                    _buildItemWidget(context, BottomNavBarType.plan),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItemWidget(BuildContext context, BottomNavBarType type) {
    return GestureDetector(
      onTap: () => type.navigate(),
      child: Container(
        color: Theme.of(context).colorScheme.background,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SvgPicture.asset(
          type.icon,
          color: Theme.of(context).cardColor,
          package: AssetsPackage.omniGeneral,
          height: 40,
          width: 40,
        ),
      ),
    );
  }

  Widget _buildNotificationIconWidget(
    BuildContext context,
    BottomNavBarType type,
  ) {
    return GestureDetector(
      onTap: () => type.navigate(),
      child: Stack(
        children: [
          Container(
            color: Theme.of(context).colorScheme.background,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SvgPicture.asset(
              type.icon,
              color: Theme.of(context).cardColor,
              package: AssetsPackage.omniGeneral,
              height: 40,
              width: 40,
            ),
          ),
          Positioned(
            top: 0,
            right: 10,
            child: Visibility(
              visible: unreadNotificationStore.state > 0,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                child: Text(
                  unreadNotificationStore.state.toString(),
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).colorScheme.background,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
