import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'widgets/about_settings.dart';
import 'widgets/general_settings.dart';

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
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
      return PlatformScaffold(
        appBar: PlatformAppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Settings",
            style: TextStyle(color: theme.getTheme.hoverColor),
          ),
          backgroundColor: theme.getTheme.appBarTheme.color,
        ),
        body: Material(
          child: Center(
              child: Column(
            children: <Widget>[
              GeneralSettings(theme: theme),
              AboutSettings(theme: theme)
            ],
          )),
        ),
      );
    });
  }
}
