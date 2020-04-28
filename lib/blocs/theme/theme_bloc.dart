import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/theme.dart' as theme;

enum ThemeEvent { toggle }

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  @override
  ThemeData get initialState => theme.lightMode;

  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    final prefs = await SharedPreferences.getInstance();
    switch (event) {
      case ThemeEvent.toggle:
        yield state == theme.darkMode ? theme.lightMode : theme.darkMode;
        break;
    }
  }
}
