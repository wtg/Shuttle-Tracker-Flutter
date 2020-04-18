part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class GetLightTheme extends ThemeEvent {
  const GetLightTheme();
  @override
  List<Object> get props => null;
}

class GetDarkTheme extends ThemeEvent {
  const GetDarkTheme();
  @override
  List<Object> get props => null;
}
