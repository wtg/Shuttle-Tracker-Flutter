import 'dart:io';

import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  accentColor: Colors.red,
  accentColorBrightness: Brightness.dark,
  appBarTheme: AppBarTheme(color: Colors.white, brightness: Brightness.light),
  backgroundColor: Colors.white,
  bottomAppBarColor: Colors.white,
  hoverColor: Colors.black,
  primarySwatch: Colors.red,
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: Colors.black,
        fontSize: Platform.isIOS ? 11.0 : 13.0,
        fontStyle: FontStyle.normal),
    subtitle1: TextStyle(
        color: Colors.black,
        fontSize: Platform.isIOS ? 9.0 : 11.0,
        fontStyle: FontStyle.normal),
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
  bottomAppBarColor: Colors.black,
  canvasColor: Color(0xFF181818),
  hoverColor: Colors.white,
  primarySwatch: Colors.red,
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: Colors.white,
        fontSize: Platform.isIOS ? 11.0 : 13.0,
        fontStyle: FontStyle.normal),
    subtitle1: TextStyle(
        color: Colors.white,
        fontSize: Platform.isIOS ? 9.0 : 11.0,
        fontStyle: FontStyle.normal),
  ),
);
