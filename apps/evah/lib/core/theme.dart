import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData theme = ThemeData(
  useMaterial3: true,
  dividerTheme: DividerThemeData(
    color: Colors.grey.shade300,
    space: 0,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(
      Colors.white,
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color(0xffffffff),
    // backgroundColor: Colors.white,

    elevation: 0,
    modalElevation: 0,
    clipBehavior: Clip.antiAliasWithSaveLayer,
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Color(0xffffffff),
  ),
  primaryColor: const Color(0x0fff006a).withOpacity(1),
  primaryColorDark: const Color(0x0fff006a).withOpacity(1),
  scaffoldBackgroundColor: const Color(0xffffffff),
  // scaffoldBackgroundColor: Colors.white,
  splashColor: Colors.white,
  cardColor: const Color(0xFF737375),
  dialogBackgroundColor: const Color(0xFF737375),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0x0fff006a).withOpacity(1),
    disabledColor: const Color(0x0fff006a).withOpacity(1),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.black.withOpacity(0.5),
    selectionHandleColor: Colors.black,
  ),
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.inter(
      color: const Color(0xff230630),
      fontSize: 16,
      height: 1.5,
    ),
    labelLarge: GoogleFonts.inter(
      color: const Color(0xff230630),
      fontSize: 14,
      height: 1.5,
    ),
    displayLarge: GoogleFonts.inter(
      color: const Color(0xff230630),
      fontSize: 25,
      height: 1.5,
    ),
    displayMedium: GoogleFonts.inter(
      color: const Color(0xff230630),
      fontSize: 22,
      height: 1.5,
    ),
    displaySmall: GoogleFonts.inter(
      color: const Color(0xff230630),
      fontSize: 20,
      height: 1.5,
    ),
    headlineMedium: GoogleFonts.inter(
      color: const Color(0xff230630),
      fontSize: 18,
      height: 1.5,
    ),
    headlineSmall: GoogleFonts.inter(
      color: const Color(0xff230630),
      fontSize: 16,
      height: 1.5,
    ),
    titleLarge: GoogleFonts.inter(
      color: const Color(0xff230630),
      fontSize: 14,
      height: 1.5,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xffffffff),
  ),
  colorScheme: const ColorScheme(
    primary: Colors.black,
    primaryContainer: Colors.black,
    secondary: Colors.black,
    secondaryContainer: Colors.black,
    surface: Colors.red,
    background: Color(0xffffffff),
    // background: Colors.white,
    error: Colors.red,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Color(0xffffffff),
    onError: Colors.red,
    brightness: Brightness.light,
  ),
);
