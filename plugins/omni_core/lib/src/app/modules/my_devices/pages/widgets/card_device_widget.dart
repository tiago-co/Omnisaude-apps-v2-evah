import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardDeviceWidget extends StatefulWidget {
  final String title;
  final String asset;
  final String package;
  final GestureTapCallback? onTap;
  final bool isImage;
  const CardDeviceWidget({
    Key? key,
    required this.title,
    required this.asset,
    required this.package,
    this.onTap,
    required this.isImage,
  }) : super(key: key);

  @override
  State<CardDeviceWidget> createState() => _CardDeviceWidgetState();
}

class _CardDeviceWidgetState extends State<CardDeviceWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        height: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.isImage)
              Column(
                children: [
                  Image.asset(
                    widget.asset,
                    package: widget.package,
                    width: 120,
                    height: 120,
                  ),
                ],
              )
            else
              SvgPicture.asset(
                widget.asset,
                package: widget.package,
                color: Theme.of(context).primaryColor,
                width: 120,
                height: 120,
              ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
