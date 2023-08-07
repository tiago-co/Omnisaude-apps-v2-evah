import 'package:flutter/material.dart';
import 'package:omni_general/omni_general.dart';

class DeviceTypeCardWidget extends StatelessWidget {
  final String? image;
  final String? package;
  final String title;
  final String description;
  final Function()? onTap;
  const DeviceTypeCardWidget({
    Key? key,
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
        elevation: 4,
        shadowColor: Colors.black,
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10,
        ),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 0.05,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Helpers.showDialog(
                    context,
                    ColoredBox(
                      color: Colors.white,
                      child: Image.asset(
                        image!,
                        package: package,
                        width: 300,
                        height: 300,
                      ),
                    ),
                    showClose: true,
                  );
                },
                child: Image.asset(
                  image!,
                  package: package,
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
