// ignore_for_file: deprecated_member_use

import 'package:fcc_app_front/export.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  secondaryHeaderColor: gradientColor,
  canvasColor: textColor,
  primaryColorLight: primaryColorLight,
  primaryColorDark: primaryColorDark,
  errorColor: errorColor,
  hintColor: hintColor,
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontSize: 15,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w400,
      color: primaryColorDark,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w600,
      color: primaryColorDark,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w600,
      color: primaryColorDark,
    ),
    titleLarge: TextStyle(
      fontSize: 30,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w600,
      color: primaryColorDark,
    ),
    titleMedium: TextStyle(
      fontSize: 22,
      fontFamily: 'Rubik',
      fontWeight: FontWeight.w700,
      color: primaryColorDark,
    ),
  ),
);
