import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_shuttletracker/pages/settings_page/widgets/about_settings.dart';
import 'package:flutter_shuttletracker/pages/settings_page/widgets/general_settings.dart';

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
      List<Widget> aboutSettingsList = [
        ListTile(
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Send Feedback',
                style:
                    TextStyle(color: theme.getTheme.hoverColor, fontSize: 16),
              ),
              Text(
                'Any comments? Send them here!',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'FAQ',
                style:
                    TextStyle(color: theme.getTheme.hoverColor, fontSize: 16),
              ),
              Text(
                'View frequently asked questions',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
        ListTile(
          dense: true,
          leading: Text(
            'Privacy Policy',
            style: TextStyle(color: theme.getTheme.hoverColor, fontSize: 16),
          ),
        ),
        ListTile(
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Version',
                style:
                    TextStyle(color: theme.getTheme.hoverColor, fontSize: 16),
              ),
              Text(
                '1.0',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
      ];
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
