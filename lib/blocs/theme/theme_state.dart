part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  final bool isDarkMode;
  const ThemeInitial({this.isDarkMode});
  @override
  List<Object> get props => [isDarkMode];
}

class ThemeLight extends ThemeState {
  final bool isDarkMode;
  const ThemeLight({this.isDarkMode});
  @override
  List<Object> get props => [isDarkMode];
}

class ThemeDark extends ThemeState {
  final bool isDarkMode;
  const ThemeDark({this.isDarkMode});
  @override
  List<Object> get props => [isDarkMode];
}
