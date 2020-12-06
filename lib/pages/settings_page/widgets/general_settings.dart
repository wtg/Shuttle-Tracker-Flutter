import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/theme_bloc/theme_bloc.dart';

/// Class: GeneralSettings
/// Function: Represents the General settings section of the Settings Page
class GeneralSettings extends StatelessWidget {
  final ThemeState theme;
  GeneralSettings({this.theme});

  /// Standard build function for the GeneralSettings widget
  Widget build(BuildContext context) {
    var themeBloc = context.watch<ThemeBloc>();
    var isSwitched = theme.isDarkMode;
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
          color: theme.getTheme.hoverColor,
        ),
        title: Text('Dark Mode',
            style: TextStyle(color: theme.getTheme.hoverColor, fontSize: 16)),
        trailing: PlatformSwitch(
          value: isSwitched,
          onChanged: (value) {
            isSwitched = value;
            themeBloc.add(ThemeEvent.toggle);
          },
          activeColor: Colors.white,
          material: (context, _) =>
              MaterialSwitchData(activeTrackColor: Colors.green),
          cupertino: (context, _) =>
              CupertinoSwitchData(activeColor: Colors.green),
        ),
      ),
    ]);
  }
}
