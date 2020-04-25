import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  accentColor: Colors.red,
  accentColorBrightness: Brightness.dark,
  appBarTheme: AppBarTheme(color: Colors.white, brightness: Brightness.light),
  backgroundColor: Colors.white,
  bottomAppBarColor: Colors.white,
  hoverColor: Colors.black,
  primaryTextTheme: TextTheme(
    title: TextStyle(color: Colors.black),
  ),
  primarySwatch: Colors.red,
  textTheme: TextTheme(
    body1: TextStyle(color: Colors.black),
  ),
);

ThemeData darkMode = ThemeData(
  accentColor: Colors.red,
  accentColorBrightness: Brightness.light,
  appBarTheme: AppBarTheme(color: Colors.black),
  backgroundColor: Colors.grey[900],
  bottomAppBarColor: Colors.black,
  canvasColor: Colors.grey[900],
  hoverColor: Colors.white,
  primaryTextTheme: TextTheme(
    title: TextStyle(color: Colors.white),
  ),
  primarySwatch: Colors.red,
  textTheme: TextTheme(
    body1: TextStyle(color: Colors.white),
  ),
);
