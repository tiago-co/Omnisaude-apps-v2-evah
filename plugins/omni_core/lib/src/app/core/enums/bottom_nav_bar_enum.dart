import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_general/src/stores/user_store.dart';

enum BottomNavBarType { notification, drawer, plan, blog }

extension BottomNavBarTypeExtension on BottomNavBarType {
  String get asset {
    switch (this) {
      case BottomNavBarType.notification:
        return 'assets/icons/notification_one.svg';
      case BottomNavBarType.drawer:
        return 'assets/icons/perfil_config_one.svg';
      case BottomNavBarType.plan:
        return 'assets/icons/plan_one.svg';
      case BottomNavBarType.blog:
        return Assets.preventionOne;
      default:
        return toString();
    }
  }

  String get asset2 {
    switch (this) {
      case BottomNavBarType.notification:
        return 'assets/icons/notification_two.svg';
      case BottomNavBarType.drawer:
        return 'assets/icons/perfil_config_two.svg';
      case BottomNavBarType.plan:
        return 'assets/icons/plan_two.svg';
      case BottomNavBarType.blog:
        return Assets.preventionTwo;
      default:
        return toString();
    }
  }

  String get icon {
    switch (this) {
      case BottomNavBarType.notification:
        return 'assets/bottom_bar/icon_notification.svg';
      case BottomNavBarType.drawer:
        return 'assets/bottom_bar/icon_drawer.svg';
      case BottomNavBarType.plan:
        return 'assets/bottom_bar/icon_plan.svg';
      case BottomNavBarType.blog:
        return 'assets/modules/guide_providers/guide_providers_base.svg';
      default:
        return toString();
    }
  }

  Function get navigate {
    switch (this) {
      case BottomNavBarType.notification:
        return () {
          final UserStore userStore = Modular.get();
          Modular.to.pushNamed(
            '/home/notifications/',
            arguments: userStore.userId,
          );
        };
      case BottomNavBarType.drawer:
        return () {
          Modular.to.pushNamed('/home/drawer');
        };
      case BottomNavBarType.plan:
        return () {
          Modular.to.pushNamed(
            '/home/omniPlan/planCard',
            arguments: {
              'moduleName': 'Minha Assinatura',
            },
          );
        };
      case BottomNavBarType.blog:
        return () {
          Modular.to.pushNamed(
            '/home/informativesCategory',
            arguments: 'Conteúdo',
          );
        };
      default:
        return () => null;
    }
  }
}
