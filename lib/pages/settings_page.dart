import 'package:flutter/material.dart';
import 'package:flutter_shuttletracker/blocs/theme/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            
            Card(
              color: Theme.of(context).backgroundColor,
              child: Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: true,
                child: ListTile(
                  leading: Icon(
                    Icons.settings_brightness,
                    color: Theme.of(context).hoverColor,
                  ),
                  title: Text('Dark Mode',
                      style: TextStyle(
                          color: Theme.of(context).hoverColor, fontSize: 18)),
                  trailing: Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      isSwitched = value;
                      context.bloc<ThemeBloc>().add(ThemeEvent.toggle);
                    },
                    activeTrackColor: Colors.grey,
                    activeColor: Colors.red,
                  ),
                ),
              ),
            ),
            
          ],
        ));
      },
    ));
  }
}
