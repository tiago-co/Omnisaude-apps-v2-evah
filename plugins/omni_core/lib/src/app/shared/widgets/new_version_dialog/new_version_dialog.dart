import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:shared_labels/labels.dart';
import 'package:url_launcher/url_launcher.dart';

class NewVersionDialog extends StatelessWidget {
  const NewVersionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Text(
            SharedLabels.newVersionAvailable,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: 18),
          ),
          const SizedBox(height: 15),
          SvgPicture.asset(
            Assets.refresh,
            package: AssetsPackage.omniGeneral,
            color: Theme.of(context).primaryColor,
            height: 75,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                onPressed: () => Modular.to.pop(),
                child: Text(
                  SharedLabels.close,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0.5,
                    ),
                  ),
                ),
                onPressed: () async {
                  if (Platform.isIOS) {
                    await launchUrl(
                      Uri.parse(
                        'https://apps.apple.com/us/app/m%C3%A9dico-na-hora/id6454310093',
                      ),
                    );
                  }
                  if (Platform.isAndroid) {
                    await launchUrl(
                      Uri.parse(
                        'https://play.google.com/store/apps/details?id=com.omnisaude.mediconahora',
                      ),
                    );
                  }

                  Modular.to.pop();
                },
                child: SizedBox(
                  height: 20,
                  child: Text(
                    'Atualizar',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
