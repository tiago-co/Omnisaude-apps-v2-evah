import 'package:flutter/material.dart';

class SliderItemTitleWidget extends StatelessWidget {
  final String title;

  const SliderItemTitleWidget({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.15,
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
