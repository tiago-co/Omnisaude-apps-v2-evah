import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 80,
      child: Stack(
        children: [
          Positioned(
            // ellipse132G5D (I5103:27678;1302:23395)
            left: 0,
            right: 0,

            child: SizedBox(
              height: 80,
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: const Icon(Icons.person),
              ),
            ),
          ),
          const Positioned(
            // group76YHd (5103:27688)
            left: 52,
            right: 0,
            bottom: 0,
            child: Align(
              child: SizedBox(width: 28, height: 28, child: Icon(Icons.edit)),
            ),
          ),
        ],
      ),
    );
  }
}
