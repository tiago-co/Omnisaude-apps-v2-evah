import 'package:flutter/material.dart';

class DiscountHeader extends StatelessWidget {
  const DiscountHeader({
    Key? key,
    required this.title,
    this.value,
    this.subtitle,
    this.parcels,
  }) : super(key: key);
  final String title;
  final String? value;
  final String? subtitle;
  final String? parcels;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 16),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xff232120),
              letterSpacing: 0.4,
            ),
          ),
          if (value != null)
            Text(
              value!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade800,
                letterSpacing: 0.05,
              ),
            ),
        ],
      ),
      subtitle: subtitle != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subtitle!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff696969),
                    letterSpacing: 0.4,
                  ),
                ),
                if (parcels != null)
                  Text(
                    parcels!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff696969),
                      letterSpacing: 0.05,
                    ),
                  ),
              ],
            )
          : null,
    );
  }
}
