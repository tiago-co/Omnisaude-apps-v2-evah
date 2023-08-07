import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerService {
  Future<List<File>> getFiles({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    Function(FilePickerStatus)? onFileLoading,
    bool allowCompression = true,
    bool allowMultiple = false,
    bool withData = false,
    bool withReadStream = false,
  }) async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
        onFileLoading: onFileLoading,
        allowCompression: allowCompression,
        allowMultiple: allowMultiple,
        withData: withData,
        withReadStream: withReadStream,
      );
      if (result == null) return List.empty();
      return List.filled(1, File(result.files.single.path!));
    } catch (e) {
      log('getFiles: $e');
      return List.empty();
    }
  }

  Future<File?> openCamera() async {
    final ImagePicker picker = ImagePicker();
    XFile? file;
    try {
      file = await picker.pickImage(source: ImageSource.camera);
      if (file?.path == null) return null;
      return File(file!.path);
    } on PlatformException catch (e) {
      log('Erro ao abrir a camera: $e');
      return null;
    }
  }

  Future<File?> openGallery() async {
    final ImagePicker picker = ImagePicker();
    XFile? file;
    try {
      file = await picker.pickImage(source: ImageSource.gallery);
      if (file?.path == null) return null;
      return File(file!.path);
    } on PlatformException catch (e) {
      log('Erro ao obter arquivo da galeria: $e');
      return null;
    }
  }

  Future<File?> cropImage(File file) async {
    final List<CropAspectRatioPreset> android = [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9,
    ];

    final List<CropAspectRatioPreset> iOS = [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio5x3,
      CropAspectRatioPreset.ratio5x4,
      CropAspectRatioPreset.ratio7x5,
      CropAspectRatioPreset.ratio16x9,
    ];

    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: Platform.isIOS ? iOS : android,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Editar imagem',
          showCancelConfirmationDialog: true,
        ),
      ],
    );

    if (croppedFile?.path != null) {
      return File(croppedFile!.path);
    } else {
      return null;
    }
  }
}
