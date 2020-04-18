import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  bool isDarkMode;

  @override
  ThemeState get initialState => ThemeInitial(isDarkMode: false);

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is GetLightTheme) {
      isDarkMode = false;
      yield ThemeLight(isDarkMode: isDarkMode);
    } else if (event is GetDarkTheme) {
      isDarkMode = true;
      yield ThemeDark(isDarkMode: isDarkMode);
    }
  }
}
