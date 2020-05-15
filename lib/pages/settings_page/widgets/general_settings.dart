import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/theme/theme_bloc.dart';

class GeneralSettings extends StatefulWidget {
  final ThemeState theme;
  GeneralSettings({this.theme});

  @override
  _GeneralSettingsState createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  @override
  Widget build(BuildContext context) {
    var themeBloc = context.bloc<ThemeBloc>();
    var isSwitched = widget.theme.isDarkMode;
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
            Icons.settings_brightness,
            color: widget.theme.getTheme.hoverColor,
          ),
          title: Text('Dark Mode',
              style: TextStyle(
                  color: widget.theme.getTheme.hoverColor, fontSize: 16)),
          trailing: Transform.scale(
            scale: 0.90,
            child: PlatformSwitch(
                value: isSwitched,
                onChanged: (value) {
                  isSwitched = value;
                  themeBloc.add(ThemeEvent.toggle);
                },
                activeColor: Colors.white,
                android: (_) =>
                    MaterialSwitchData(activeTrackColor: Colors.green),
                ios: (_) => CupertinoSwitchData(activeColor: Colors.green)),
          )),
    ]);
  }
}
