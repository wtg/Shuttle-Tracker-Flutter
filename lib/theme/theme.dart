import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  accentColor: Colors.red,
  accentColorBrightness: Brightness.dark,
  appBarTheme: AppBarTheme(color: Colors.white, brightness: Brightness.light),
  backgroundColor: Colors.white,
  cardColor: Colors.white,
  bottomAppBarColor: Colors.white,
  brightness: Brightness.light,
  primaryColor: Colors.black,
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: Colors.black, fontSize: 14.0, fontStyle: FontStyle.normal),
    subtitle1: TextStyle(
        color: Colors.black, fontSize: 14.0, fontStyle: FontStyle.normal),
  ),
);

final ThemeData darkMode = ThemeData(
  accentColor: Colors.red,
  accentColorBrightness: Brightness.light,
  appBarTheme: AppBarTheme(
    color: Colors.black,
    brightness: Brightness.dark,
  ),
  backgroundColor: Color(0xFF181818),
  cardColor: Color(0xFF242424),
  bottomAppBarColor: Colors.black,
  brightness: Brightness.dark,
  canvasColor: Color(0xFF181818),
  primaryColor: Colors.white,
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: Colors.white, fontSize: 14.0, fontStyle: FontStyle.normal),
    subtitle1: TextStyle(
        color: Colors.white, fontSize: 14.0, fontStyle: FontStyle.normal),
  ),
);
