import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_measurement/src/new_measurement/pages/widgets/retangle_mask_widget.dart';
import 'package:omni_measurement/src/new_measurement/stores/camera_preview_flash_store.dart';
import 'package:omni_measurement_labels/labels.dart';

class CameraPreviewPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraPreviewPage({Key? key, required this.cameras}) : super(key: key);

  @override
  State<CameraPreviewPage> createState() => _CameraPreviewPageState();
}

class _CameraPreviewPageState extends State<CameraPreviewPage> {
  int cameraSize = 0;

  late CameraController controller = CameraController(
    widget.cameras[cameraSize],
    ResolutionPreset.ultraHigh,
    enableAudio: false,
    imageFormatGroup: ImageFormatGroup.jpeg,
  );
  final CameraPreviewFlashStore flashStore = Modular.get();
  Future<void> initCamera() async {
    controller.setFlashMode(flashStore.state);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            log('User denied camera access.');
            break;
          default:
            log('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void initState() {
    initCamera();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Transform.scale(
            scale: 1,
            child: Center(
              child: AspectRatio(
                aspectRatio: size.width / size.height,
                child: CustomPaint(
                  foregroundPainter: RetangleMaskPainter(),
                  child: CameraPreview(controller),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 15, top: 15),
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              height: 100,
              alignment: Alignment.centerLeft,
              child:
                  TripleBuilder<CameraPreviewFlashStore, Exception, FlashMode>(
                store: flashStore,
                builder: (_, triple) {
                  return IconButton(
                    onPressed: () async {
                      if (flashStore.state == FlashMode.torch) {
                        flashStore.updateFlash(FlashMode.off);
                        controller.setFlashMode(flashStore.state);
                      } else if (flashStore.state == FlashMode.off) {
                        flashStore.updateFlash(FlashMode.torch);
                        controller.setFlashMode(flashStore.state);
                      }
                    },
                    icon: Icon(
                      flashStore.state == FlashMode.torch
                          ? Icons.flash_on
                          : Icons.flash_off,
                      color: Theme.of(context).colorScheme.background,
                      size: 30,
                    ),
                  );
                },
              ),
            ),
          ),
          // Positioned(
          //   top: 60,
          //   right: 20,
          //   child: GestureDetector(
          //     onTap: () {
          //       Modular.to.pop();
          //     },
          //     child: Container(
          //       padding: const EdgeInsets.all(10),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       child: SvgPicture.asset(
          //         'assets/icons/close.svg',
          //         height: 20,
          //         width: 20,
          //         package: AssetsPackage.omniGeneral,
          //         color: Theme.of(context).primaryColor,
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 50, bottom: 30),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Modular.to.pop();
                    },
                    child: Text(
                      MeasurementLabels.cameraPreviewCancel,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Colors.white,
                              ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await controller.takePicture().then((xfile) async {
                        XFile? file;
                        try {
                          file = xfile;
                          await Modular.to
                              .pushNamed(
                            '/home/measurements/newMeasurement/confirm_photo',
                            arguments: File(file.path),
                          )
                              .then((useThisPhoto) {
                            if (useThisPhoto == true) {
                              Modular.to.pop(File(file!.path));
                            }
                          });
                        } on PlatformException catch (e) {
                          log('Erro ao abrir a camera: $e');
                          return null;
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // if (cameraSize == 0) {
                      //   cameraSize = 1;
                      // } else {
                      //   cameraSize = 0;
                      // }
                      // controller = CameraController(
                      //   widget.cameras[cameraSize],
                      //   ResolutionPreset.ultraHigh,
                      // );
                      // initCamera();
                    },
                    icon: const Icon(
                      Icons.change_circle_outlined,
                      color: Colors.transparent,
                      size: 45,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
