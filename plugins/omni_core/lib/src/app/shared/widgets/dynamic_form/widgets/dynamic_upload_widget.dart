import 'package:flutter/material.dart';
import 'package:omni_core/src/app/core/models/upload_field_model.dart';

class DynamicUploadWidget extends StatefulWidget {
  final UploadFieldModel upload;
  final bool readOnly;

  const DynamicUploadWidget({
    Key? key,
    required this.upload,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _DynamicUploadWidgetState createState() => _DynamicUploadWidgetState();
}

class _DynamicUploadWidgetState extends State<DynamicUploadWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(height: 100, color: Colors.blue, width: double.infinity);
  }
}
