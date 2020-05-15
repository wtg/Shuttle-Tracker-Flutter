import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../blocs/theme/theme_bloc.dart';
import 'widgets/about_settings.dart';
import 'widgets/feedback_settings.dart';
import 'widgets/general_settings.dart';

class SettingsPage extends StatefulWidget {
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
            'Settings',
            style: TextStyle(color: theme.getTheme.hoverColor),
          ),
          backgroundColor: theme.getTheme.appBarTheme.color,
        ),
        body: Material(
          child: Center(
              child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return null;
            },
            child: ListView(
              children: <Widget>[
                GeneralSettings(theme: theme),
                FeedbackSettings(theme: theme),
                AboutSettings(theme: theme)
              ],
            ),
          )),
        ),
      );
    });
  }
}