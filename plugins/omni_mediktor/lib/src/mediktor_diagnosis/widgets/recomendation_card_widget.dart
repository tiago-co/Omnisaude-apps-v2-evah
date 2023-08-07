import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecomendationCardWidget extends StatelessWidget {
  final String? asset;
  final String? baseAsset;
  final String? image;
  final String? package;
  final String title;
  final String description;
  final Function()? onTap;
  const RecomendationCardWidget({
    Key? key,
    this.asset,
    this.baseAsset,
    this.package,
    this.image,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 0.1,
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (image != null)
                Image.network(
                  image!,
                  width: 120,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              if (asset != null)
                Stack(
                  children: [
                    SvgPicture.asset(
                      baseAsset ?? '',
                      color: Theme.of(context).primaryColor,
                      package: package,
                      width: 50,
                    ),
                    SvgPicture.asset(
                      asset ?? '',
                      color: Theme.of(context).primaryColor,
                      package: package,
                      width: 50,
                    ),
                  ],
                ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
                subtitle: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
