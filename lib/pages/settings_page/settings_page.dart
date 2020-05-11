import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../blocs/theme/theme_bloc.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, theme) {
        bool isSwitched = theme.isDarkMode;
        return SettingsList(
          sections: [
            SettingsSection(
              title: 'Section',
              tiles: [
                SettingsTile.switchTile(
                  title: 'Dark Mode',
                  leading: Icon(
                    Icons.settings_brightness,
                    color: theme.getTheme.hoverColor,
                  ),
                  switchValue: isSwitched,
                  onToggle: (bool value) {
                    isSwitched = value;
                    context.bloc<ThemeBloc>().add(ThemeEvent.toggle);
                  },
                ),
              ],
            ),
          ],
        );
        /*
        return Center(
            child: ListView(
          children: <Widget>[
            ListTile(
                leading: Icon(
                  Icons.settings_brightness,
                  color: theme.getTheme.hoverColor,
                ),
                title: Text('Dark Mode',
                    style: TextStyle(
                        color: theme.getTheme.hoverColor, fontSize: 18)),
                trailing: PlatformSwitch(
                    value: isSwitched,
                    onChanged: (value) {
                      isSwitched = value;
                      context.bloc<ThemeBloc>().add(ThemeEvent.toggle);
                    },
                    activeColor: Colors.white,
                    android: (_) =>
                        MaterialSwitchData(activeTrackColor: Colors.green),
                    ios: (_) =>
                        CupertinoSwitchData(activeColor: Colors.green))),
          ],
        ));
        */
      },
    ));
  }
}
