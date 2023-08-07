import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/core/models/informative_model.dart';
import 'package:omni_general/omni_general.dart';

class InformativeItemWidget extends StatelessWidget {
  final InformativeModel informative;

  const InformativeItemWidget({
    Key? key,
    required this.informative,
  }) : super(key: key);

  String dateToString() {
    final String date = Formaters.dateToStringDateTime(
      Formaters.stringToDateTime(informative.updatedAt!),
    );
    final int spaceIndex = date.indexOf(' ');
    return '${date.substring(0, spaceIndex)}'
        ' às${date.substring(spaceIndex, date.length)}';
  }

  @override
  Widget build(BuildContext context) {
    if (informative.banner != null) {
      CachedNetworkImage.evictFromCache(informative.banner!);
    }
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed('detailsInformative', arguments: informative);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    informative.title ?? 'Sem título',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    dateToString(),
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).cardColor.withOpacity(0.75),
                          fontSize: 12,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Theme.of(context).colorScheme.background,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                border: informative.banner == null
                    ? null
                    : Border.all(
                        color: Colors.grey.withOpacity(0.1),
                        width: 1.5,
                      ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ImageWidget(
                borderRadius: BorderRadius.circular(10),
                url: informative.banner ?? '',
                asset: Assets.informativeCategoryItem,
                package: AssetsPackage.omniCore,
                boxFit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 7.2,
                width: MediaQuery.of(context).size.width / 3.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
