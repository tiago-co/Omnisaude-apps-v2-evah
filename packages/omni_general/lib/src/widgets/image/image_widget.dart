import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_general/omni_general.dart';

class ImageWidget extends StatelessWidget {
  final String url;
  final String asset;
  final String assetBase;
  final String? package;
  final BoxFit? boxFit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ImageWidget({
    Key? key,
    required this.url,
    this.asset = '',
    this.assetBase = '',
    this.package,
    this.boxFit,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      child: url.isEmpty
          ? _buildAssetWidget(context)
          : ClipRRect(
              borderRadius: borderRadius,
              child: CachedNetworkImage(
                errorWidget: (_, String url, dynamic error) {
                  return _buildAssetWidget(context);
                },
                imageBuilder: (_, ImageProvider imageProvider) {
                  return GestureDetector(
                    onTap: () {
                      Helpers.showDialog(
                        context,
                        PhotoViewWidget(image: imageProvider),
                        showClose: true,
                      );
                    },
                    child: Image(
                      image: imageProvider,
                      fit: boxFit ?? BoxFit.contain,
                    ),
                  );
                },
                placeholder: (_, String url) {
                  height != null
                      ? height! <= 15
                          ? 10
                          : 15
                      : null;
                  width != null
                      ? width! <= 15
                          ? 10
                          : 15
                      : null;
                  return SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                      strokeWidth: 1.5,
                    ),
                  );
                },
                imageUrl: url,
              ),
            ),
    );
  }

  Widget _buildAssetWidget(BuildContext context) {
    return Stack(
      children: [
        if (assetBase.isNotEmpty)
          Center(
            child: SvgPicture.asset(
              assetBase,
              width: width,
              height: height,
              package: package,
              color: Theme.of(context).cardColor,
              fit: boxFit ?? BoxFit.contain,
            ),
          ),
        Center(
          child: SvgPicture.asset(
            asset,
            width: width,
            height: height,
            package: package,
            color: assetBase.isNotEmpty ? Theme.of(context).primaryColor : null,
            fit: boxFit ?? BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
