import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/theme_bloc/theme_bloc.dart';

/// Class: GeneralSettings
/// Function: Represents the General settings section of the Settings Page
class GeneralSettings extends StatelessWidget {
  /// Standard build function for the GeneralSettings widget
  @override
  Widget build(BuildContext context) {
    var themeBloc = context.watch<ThemeBloc>();
    var theme = themeBloc.state.getTheme;
    var isSwitched = themeBloc.state.isDarkMode;
    return Column(children: <Widget>[
      ListTile(
        dense: true,
        leading: Text(
          'General',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
        ),
      ),
      ListTile(
          dense: true,
          leading: Icon(
            Icons.brightness_medium,
            color: theme.primaryColor,
          ),
          title: Text('Dark Mode',
              style: TextStyle(color: theme.primaryColor, fontSize: 16)),
          trailing: Switch(
            key: Key('themeSwitch'),
            value: isSwitched,
            onChanged: (value) {
              isSwitched = value;
              themeBloc.add(ThemeEvent.toggle);
            },
            activeColor: Colors.white,
            activeTrackColor: Colors.green,
          )),
    ]);
  }
}
