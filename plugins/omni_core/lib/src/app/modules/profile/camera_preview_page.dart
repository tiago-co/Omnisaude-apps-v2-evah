import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/profile/widgets/retangle_mask_widget.dart';
import 'package:profile_labels/labels.dart';

class CameraPreviewPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraPreviewPage({Key? key, required this.cameras}) : super(key: key);

  @override
  State<CameraPreviewPage> createState() => _CameraPreviewPageState();
}

class _CameraPreviewPageState extends State<CameraPreviewPage> {
  int cameraSize = 0;
  FlashMode flashMode = FlashMode.auto;
  IconData icon = Icons.flash_auto;
  late CameraController controller = CameraController(
    widget.cameras[cameraSize],
    ResolutionPreset.ultraHigh,
    enableAudio: false,
    imageFormatGroup: ImageFormatGroup.jpeg,
  );
  Future<void> initCamera() async {
    controller.setFlashMode(flashMode);
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
              child: IconButton(
                onPressed: () async {
                  // if (flashMode == FlashMode.auto) {
                  //   flashMode = FlashMode.torch;
                  //   controller.setFlashMode(flashMode);
                  //   icon = Icons.flash_on;
                  // } else if (flashMode == FlashMode.torch) {
                  //   flashMode = FlashMode.off;
                  //   controller.setFlashMode(flashMode);
                  //   icon = Icons.flash_off;
                  // } else if (flashMode == FlashMode.off) {
                  //   flashMode = FlashMode.always;
                  //   controller.setFlashMode(flashMode);
                  //   icon = Icons.flash_on;
                  // } else if (flashMode == FlashMode.always) {
                  //   flashMode = FlashMode.auto;
                  //   controller.setFlashMode(flashMode);
                  //   icon = Icons.flash_auto;
                  // }
                  // setState(() {});
                },
                icon: Icon(
                  icon,
                  color: Colors.transparent,
                  size: 30,
                ),
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
          //         package: 'omni_general',
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
                    child: const Text(ProfileLabels.cameraPreviewCancel),
                  ),
                  InkWell(
                    onTap: () async {
                      await controller.takePicture().then((xfile) async {
                        XFile? file;
                        try {
                          file = xfile;
                          await Modular.to
                              .pushNamed(
                            '/home/profile/confirm_photo',
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
