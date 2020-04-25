import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/theme/theme_bloc.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ThemeBloc, ThemeData>(
      builder: (context, theme) {
        return Center(
            child: ListView(
          children: <Widget>[
            ListTile(
                leading: Icon(
                  Icons.settings_brightness,
                  color: theme.hoverColor,
                ),
                title: Text('Dark Mode',
                    style: TextStyle(color: theme.hoverColor, fontSize: 18)),
                trailing: PlatformSwitch(
                  value: isSwitched,
                  onChanged: (value) {
                    isSwitched = value;
                    context.bloc<ThemeBloc>().add(ThemeEvent.toggle);
                  },
                  activeColor: Colors.red,
                  android: (_) =>
                      MaterialSwitchData(activeTrackColor: Colors.grey),
                )),
          ],
        ));
      },
    ));
  }
}
