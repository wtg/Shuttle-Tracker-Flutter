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
    return Scaffold(
        appBar: AppBar(
          title: Text('SettingsPage'),
        ),
        body: BlocBuilder<ThemeBloc, ThemeData>(
          builder: (context, theme) {
            return Center(
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Switch(
                value: isSwitched,
                onChanged: (value) {
                  isSwitched = value;
                  context.bloc<ThemeBloc>().add(ThemeEvent.toggle);
                },
                activeTrackColor: Colors.grey,
                activeColor: Colors.red,
              ),
            ));
          },
        ));
  }
}
