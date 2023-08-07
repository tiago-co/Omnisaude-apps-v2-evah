import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: avoid_classes_with_only_static_members
/// You can define some common sizes here
/// and call them with `AppSizes.textXs`.
///
/// Or you can use:
/// [wSize] for widht, [hSize] for height and [textSize] for sp
///
/// *Example*:
///
///   Size:
///   ```dart
///     SizedBox(
///       width: AppSizes.wSize(50),
///       height: AppSizes.hSize(50),
///     ),
///   ```
///
///   FontSize:
///   ```dart
///      Text(
///        "Example",
///        style: TextStyle(
///            fontSize: AppSizes.textSize(16),
///         ),
///      ),
///   ```
class AppSizes {
  static const double textScaleFactor = 1;
  static const double baseWithDesign = 375;
  static const double baseHeightDesign = 812;
  static const double zero = 0;
  static const double twenty = 20;

  /// Scale the width
  static double wSize(double size) => ScreenUtil().setWidth(size);

  /// Scale the height
  static double hSize(double size) => ScreenUtil().setHeight(size);

  /// Scale fontSizes
  static double textSize(double size) => ScreenUtil().setSp(size);

  /// Scale padding
  static double paddingSize(double size) => ScreenUtil().setWidth(size);

  static double defaultPadding = paddingSize(16);

  /// Scale the radius
  static double radiusSize(double size) => ScreenUtil().setHeight(size);

  // Some common TextSizes:
  static double text5 = textSize(5);
  static double text10 = textSize(10);
  static double text11 = textSize(11);
  static double text12 = textSize(12);
  static double text13 = textSize(13);
  static double text14 = textSize(14);
  static double text15 = textSize(15);
  static double text16 = textSize(16);
  static double text20 = textSize(20);

  // Some common width
  static double width5 = wSize(5);
  static double width10 = wSize(10);
  static double width15 = wSize(15);
  static double width16 = wSize(16);
  static double width24 = wSize(24);
  static double width25 = wSize(25);
  static double width40 = wSize(40);

  // Some common height
  static double height5 = hSize(5);
  static double height10 = hSize(10);
  static double height15 = hSize(15);
  static double height16 = hSize(16);
  static double height24 = hSize(24);
  static double height25 = hSize(25);
  static double height40 = hSize(40);

  static double radius10 = radiusSize(10);
  static double radius15 = radiusSize(15);
}
