import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/omni_core.dart';

class BuildAssetsWidget extends StatelessWidget {
  final String asset;
  final String assetBase;
  final String? package;
  final BoxFit? boxFit;
  final double? width;
  final double? height;
  final Widget message;

  const BuildAssetsWidget({
    Key? key,
    this.asset = '',
    this.assetBase = '',
    this.package,
    this.boxFit,
    this.width,
    this.height,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        if (assetBase.isNotEmpty)
          Center(
            child: SvgPicture.asset(
              assetBase,
              width: 200,
              height: height,
              package: package ?? AssetsPackage.omniGeneral,
              fit: boxFit ?? BoxFit.contain,
            ),
          ),
        Center(
          child: SvgPicture.asset(
            asset,
            width: 200,
            height: height,
            package: package ?? AssetsPackage.omniGeneral,
            fit: boxFit ?? BoxFit.contain,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: message,
          ),
        ),
      ],
    );
  }
}
