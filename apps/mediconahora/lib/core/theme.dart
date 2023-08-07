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
    backgroundColor: Colors.white,
    elevation: 0,
    modalElevation: 0,
    clipBehavior: Clip.antiAliasWithSaveLayer,
  ),
  primaryColor: const Color(0xFF0091EA).withOpacity(1),
  primaryColorDark: const Color(0xFF0091EA).withOpacity(1),
  scaffoldBackgroundColor: Colors.white,
  splashColor: Colors.white,
  cardColor: const Color(0xFF737375),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xFF0091EA).withOpacity(1),
    disabledColor: const Color(0xFF0091EA).withOpacity(1),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.black.withOpacity(0.5),
    selectionHandleColor: Colors.black,
  ),
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.comfortaa(
      color: const Color(0xFF747476),
      fontSize: 16,
      height: 1.5,
    ),
    labelLarge: GoogleFonts.comfortaa(
      color: const Color(0xFF747476),
      fontSize: 14,
      height: 1.5,
    ),
    displayLarge: GoogleFonts.comfortaa(
      color: const Color(0xFF747476),
      fontSize: 25,
      height: 1.5,
    ),
    displayMedium: GoogleFonts.comfortaa(
      color: const Color(0xFF747476),
      fontSize: 22,
      height: 1.5,
    ),
    displaySmall: GoogleFonts.comfortaa(
      color: const Color(0xFF747476),
      fontSize: 20,
      height: 1.5,
    ),
    headlineMedium: GoogleFonts.comfortaa(
      color: const Color(0xFF747476),
      fontSize: 18,
      height: 1.5,
    ),
    headlineSmall: GoogleFonts.comfortaa(
      color: const Color(0xFF747476),
      fontSize: 16,
      height: 1.5,
    ),
    titleLarge: GoogleFonts.comfortaa(
      color: const Color(0xFF747476),
      fontSize: 14,
      height: 1.5,
    ),
  ),
  colorScheme: const ColorScheme(
    primary: Colors.black,
    primaryContainer: Colors.black,
    secondary: Colors.black,
    secondaryContainer: Colors.black,
    surface: Colors.red,
    background: Colors.white,
    error: Colors.red,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.white,
    onError: Colors.red,
    brightness: Brightness.light,
  ),
);
