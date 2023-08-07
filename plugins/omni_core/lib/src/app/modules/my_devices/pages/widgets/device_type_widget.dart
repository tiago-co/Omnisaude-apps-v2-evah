import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TypeDeviceMeasure extends StatelessWidget {
  final String title;
  final String asset;
  final String package;
  final GestureTapCallback? onTap;
  final bool isImage;
  const TypeDeviceMeasure({
    Key? key,
    required this.title,
    required this.asset,
    required this.package,
    this.onTap,
    required this.isImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
      splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor.withOpacity(0.025),
          ),
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor.withOpacity(0.025),
            ),
            padding: const EdgeInsets.all(5),
            child: isImage
                ? Column(
                    children: [
                      Image.asset(
                        asset,
                        package: package,
                        width: 60,
                        height: 60,
                      ),
                    ],
                  )
                : SvgPicture.asset(
                    asset,
                    package: package,
                    color: Theme.of(context).primaryColor,
                    width: 30,
                    height: 30,
                  ),
          ),
        ),
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Theme.of(context).cardColor.withOpacity(0.5),
          size: 30,
        ),
      ),
    );
  }
}
