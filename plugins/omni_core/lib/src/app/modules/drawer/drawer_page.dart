import 'package:drawer_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/modules/drawer/stores/about_store.dart';
import 'package:omni_core/src/app/modules/drawer/stores/drawer_store.dart';
import 'package:omni_core/src/app/modules/drawer/widgets/drawer_header_widget.dart';
import 'package:omni_core/src/app/modules/drawer/widgets/drawer_menu_item.dart';
import 'package:omni_core/src/app/modules/drawer/widgets/program_active_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:package_info/package_info.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final DrawerStore store = Modular.get();
  final AboutStore aboutStore = Modular.get();
  final UserStore userStore = Modular.get();
  final ModulesStore modulesStore = Modular.get();
  bool myDevicesIsEnabled = false;

  @override
  void initState() {
    aboutStore.getPackageInfo();
    modulesStore.state.forEach(
      (element) {
        if (element.type == ModuleType.measurement) {
          myDevicesIsEnabled = true;
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).colorScheme.background,
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const DrawerHeaderWidget(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: _buildMenuItemsWidget,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget get _buildMenuItemsWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const ProgramActiveWidget(),
        const Divider(),
        DrawerMenuItem(
          onTap: () => Modular.to.pushNamed('../profile'),
          title: DrawerLabels.drawerProfile,
          asset: Assets.profile,
          assetBase: Assets.profileBase,
          package: AssetsPackage.omniCore,
        ),
        const Divider(),
        // DrawerMenuItem(
        //   onTap: () => Modular.to.pushNamed('../settings'),
        //   title: DrawerLabels.drawerSettings,
        //   asset: Assets.configAppTwo,
        //   assetBase: Assets.configAppOne,
        //   package: AssetsPackage.omniCore,
        // ),
        Visibility(
          visible: myDevicesIsEnabled,
          child: Column(
            children: [
              const Divider(),
              DrawerMenuItem(
                onTap: () => Modular.to.pushNamed('my_devices'),
                title: DrawerLabels.drawerDevices,
                asset: Assets.connection,
                assetBase: Assets.connectionBase,
                package: AssetsPackage.omniCore,
              ),
            ],
          ),
        ),
        const Divider(),
        DrawerMenuItem(
          onTap: () => Modular.to.pushNamed(
            '/terms',
            // arguments: store.programStore.programSelected.code,
          ),
          title: DrawerLabels.drawerTerms,
          asset: Assets.terms,
          assetBase: Assets.termsBase,
          package: AssetsPackage.omniCore,
        ),
        const Divider(),
        DrawerMenuItem(
          onTap: () => Modular.to.pushNamed('assistance'),
          title: DrawerLabels.drawerHelp,
          asset: Assets.help,
          assetBase: Assets.helpBase,
          package: AssetsPackage.omniCore,
        ),
        const Divider(),
        DrawerMenuItem(
          showTrailingIcon: false,
          onTap: () => Helpers.showDialog(
            context,
            _buildExitWidget(context),
          ),
          title: DrawerLabels.drawerExit,
          asset: Assets.exit,
          package: AssetsPackage.omniGeneral,
        ),
        const Divider(),
        TripleBuilder<AboutStore, Exception, PackageInfo>(
          store: aboutStore,
          builder: (_, triple) {
            return RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '${DrawerLabels.drawerVersion}: ',
                style: Theme.of(context).textTheme.titleLarge,
                children: [
                  TextSpan(
                    text: '${triple.state.version} (${triple.state.buildNumber})',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

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
}
