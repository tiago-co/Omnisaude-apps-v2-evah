import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/env_enum.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/core/services/logout_service.dart';
import 'package:omni_core/src/app/shared/easter_eggs/stores/easter_eggs_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:shared_labels/labels.dart';

class EggsChangeEnvWidget extends StatefulWidget {
  const EggsChangeEnvWidget({
    Key? key,
  }) : super(key: key);

  @override
  EggsChangeEnvWidgetState createState() => EggsChangeEnvWidgetState();
}

class EggsChangeEnvWidgetState extends State<EggsChangeEnvWidget> {
  final EasterEggsStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    store.checkEnvType();
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(15),
      child: TripleBuilder(
        store: store,
        builder: (_, triple) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BottomSheetHeaderWidget(
                title: SharedLabels.eggschangeEnvTitle,
              ),
              if (!triple.isLoading) const SizedBox(height: 2.5),
              if (triple.isLoading)
                LinearProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                  color: Theme.of(context).colorScheme.background,
                  minHeight: 2.5,
                ),
              Flexible(
                child: Opacity(
                  opacity: triple.isLoading ? 0.5 : 1.0,
                  child: ListView.separated(
                    itemCount: EnvType.values.length,
                    shrinkWrap: true,
                    reverse: true,
                    padding: EdgeInsets.zero,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (_, index) {
                      return AbsorbPointer(
                        absorbing: triple.isLoading,
                        child: _buildEnvItemWidget(EnvType.values[index]),
                      );
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildEnvItemWidget(EnvType env) {
    return ListTile(
      dense: false,
      onTap: () {
        store.onChangeEnv(env).then((value) async {
          Modular.to.pop();
          await LogoutService.logout();
        }).catchError((onError) {
          Helpers.showDialog(
            context,
            RequestErrorWidget(
              error: onError,
              onPressed: () => Modular.to.pop(),
              buttonText: SharedLabels.close,
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        env.label,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      minLeadingWidth: 0,
      trailing: store.environmentType == env
          ? SvgPicture.asset(
              Assets.arrowRight,
              color: Theme.of(context).primaryColor,
              package: AssetsPackage.omniGeneral,
            )
          : null,
    );
  }
}
