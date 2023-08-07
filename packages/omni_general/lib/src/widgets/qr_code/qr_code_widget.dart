import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeWidget extends StatelessWidget {
  final String code;

  const QrCodeWidget({Key? key, required this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width * 0.35;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.background,
          ),
          padding: const EdgeInsets.all(10),
          child: CustomPaint(
            size: Size.square(size),
            painter: QrPainter(
              data: code,
              version: QrVersions.auto,
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.circle,
                color: Colors.black,
              ),
              embeddedImageStyle: QrEmbeddedImageStyle(
                size: const Size.square(30),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
