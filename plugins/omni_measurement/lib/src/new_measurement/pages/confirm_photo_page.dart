import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_measurement_labels/labels.dart';

class ConfirmPhotoPage extends StatelessWidget {
  final File file;
  const ConfirmPhotoPage({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).colorScheme.background,
        backgroundColor: Colors.black,
        leading: const SizedBox(),
      ),
      body: ColoredBox(
        color: Colors.black,
        child: Center(
          child: Image.file(
            file,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 130,
        padding: const EdgeInsets.all(15),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Modular.to.pop(false);
              },
              child: Text(
                MeasurementLabels.confirmPhotoRedo,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            TextButton(
              onPressed: () {
                Modular.to.pop(true);
              },
              child: Text(
                MeasurementLabels.confirmPhotoConfirm,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
