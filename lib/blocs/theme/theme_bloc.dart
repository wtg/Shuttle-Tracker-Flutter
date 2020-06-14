import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../theme/theme.dart' as theme;

enum ThemeEvent { toggle }

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState {
    // If there is no saved json data, choose light mode
    return super.initialState ?? ThemeState(isDarkMode: false);
  }

  @override
  ThemeState fromJson(Map<String, dynamic> source) {
    try {
      return ThemeState(isDarkMode: source['isDarkMode'] as bool);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, bool> toJson(ThemeState state) {
    try {
      return {'isDarkMode': state.isDarkMode};
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    switch (event) {
      case ThemeEvent.toggle:
        yield state.isDarkMode == true
            ? ThemeState(isDarkMode: false)
            : ThemeState(isDarkMode: true);
        break;
    }
  }
}

class ThemeState {
  bool isDarkMode;

  ThemeState({this.isDarkMode});

  ThemeData get getTheme => isDarkMode ? theme.darkMode : theme.lightMode;
  bool get getThemeState => isDarkMode;
}
