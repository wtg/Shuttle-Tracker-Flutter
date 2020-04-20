import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

enum ThemeEvent { toggle }

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
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
    canvasColor: Colors.black,
    primarySwatch: Colors.red,
    appBarTheme: AppBarTheme(color: Colors.black),
  );

  @override
  ThemeData get initialState => lightMode;

  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    switch (event) {
      case ThemeEvent.toggle:
        yield state == darkMode ? lightMode : darkMode;
        break;
    }
  }
}
