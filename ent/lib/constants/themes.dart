import 'package:flutter/material.dart';

const Color lightThemePrimaryColor = Color(0xffFFFFFF);
const Color lightThemePrimaryColorDark = Color(0xffE5EBF0);
const Color lightThemeAccentColor = Color(0xff5B37B7);

const Color darkThemePrimaryColor = Color(0xff212121);
const Color darkThemePrimaryColorDark = Color(0xff2B2B2B);
const Color darkThemeAccentColor = Color(0xff68F0AE);

List<ThemeData> themes = [lightTheme, darkTheme];

final darkTheme = ThemeData(
  primaryColor: darkThemePrimaryColor,
  primaryColorDark: darkThemePrimaryColorDark,
  accentColor: darkThemeAccentColor,
  canvasColor: Colors.transparent,
  primaryIconTheme: IconThemeData(color: Colors.white),
  // textTheme: TextTheme(
  //   headline5: TextStyle(
  //       fontFamily: 'Sans',
  //       fontWeight: FontWeight.bold,
  //       color: Colors.white,
  //       fontSize: 24),
  //   bodyText2: TextStyle(
  //       fontFamily: 'Sans',
  //       fontWeight: FontWeight.bold,
  //       color: Colors.white,
  //       fontSize: 18),
  //   bodyText1: TextStyle(
  //       fontFamily: 'Sans',
  //       fontWeight: FontWeight.bold,
  //       color: Colors.white,
  //       fontSize: 16),
  //   caption: TextStyle(
  //       fontFamily: 'Sans',
  //       fontWeight: FontWeight.bold,
  //       color: Colors.white,
  //       fontSize: 13),
  // ),
);

final lightTheme = ThemeData(
  primaryColorDark: lightThemePrimaryColorDark,
  primaryColor: lightThemePrimaryColor,
  accentColor: lightThemeAccentColor,
  canvasColor: Colors.transparent,
  primaryIconTheme: IconThemeData(color: Colors.black),
  // textTheme: TextTheme(
  //   headline5: TextStyle(
  //       fontFamily: 'Sans',
  //       fontWeight: FontWeight.bold,
  //       color: Colors.black,
  //       fontSize: 24),
  //   bodyText2: TextStyle(
  //       fontFamily: 'Sans',
  //       fontWeight: FontWeight.bold,
  //       color: Colors.black,
  //       fontSize: 18),
  //   bodyText1: TextStyle(
  //       fontFamily: 'Sans',
  //       fontWeight: FontWeight.bold,
  //       color: Colors.black,
  //       fontSize: 16),
  //   caption: TextStyle(
  //       fontFamily: 'Sans',
  //       fontWeight: FontWeight.bold,
  //       color: Colors.black,
  //       fontSize: 13),
  // ),
);
