import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  accentColor: Colors.red,
  hoverColor: Colors.black,
  accentColorBrightness: Brightness.dark,
  bottomAppBarColor: Colors.white,
  backgroundColor: Colors.white,
  textTheme: TextTheme(
    body1: TextStyle(color: Colors.black),
  ),
  primaryTextTheme: TextTheme(
    title: TextStyle(color: Colors.black),
  ),
  primarySwatch: Colors.red,
  appBarTheme: AppBarTheme(color: Colors.white, brightness: Brightness.light),
);

ThemeData darkMode = ThemeData(
  accentColor: Colors.red,
  accentColorBrightness: Brightness.light,
  hoverColor: Colors.white,
  backgroundColor: Colors.grey[900],
  bottomAppBarColor: Colors.black,
  textTheme: TextTheme(
    body1: TextStyle(color: Colors.white),
  ),
  primaryTextTheme: TextTheme(
    title: TextStyle(color: Colors.white),
  ),
  canvasColor: Colors.grey[900],
  primarySwatch: Colors.red,
  appBarTheme: AppBarTheme(color: Colors.black),
);
