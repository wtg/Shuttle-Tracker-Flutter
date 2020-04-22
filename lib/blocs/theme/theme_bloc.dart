import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

enum ThemeEvent { toggle }

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
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
    primaryIconTheme: IconThemeData(color: Colors.red),
    canvasColor: Colors.grey[900],
    primarySwatch: Colors.red,
    appBarTheme: AppBarTheme(color: Colors.black),
  );

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
    primaryIconTheme: IconThemeData(color: Colors.red),
    primarySwatch: Colors.red,
    appBarTheme: AppBarTheme(color: Colors.white, brightness: Brightness.light),
  );

  @override
  ThemeData get initialState => lightMode;

  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    //_setSettings(state == darkMode ? true : false);

    switch (event) {
      case ThemeEvent.toggle:
        yield state == darkMode ? lightMode : darkMode;
        break;
    }
  }

/*
  _setSettings(bool isDarkMode) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }

  Future<ThemeData> _getSettings() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkMode') == true ? darkMode : lightMode;
  }
*/
}
