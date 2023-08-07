import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewWidget extends StatelessWidget {
  final ImageProvider image;

  const PhotoViewWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: PhotoView(
        imageProvider: image,
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        maxScale: PhotoViewComputedScale.covered * 2.0,
        minScale: PhotoViewComputedScale.contained * 1,
        initialScale: PhotoViewComputedScale.contained,
      ),
    );
  }
}
