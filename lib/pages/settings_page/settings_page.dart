import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/theme_bloc/theme_bloc.dart';
import '../../widgets/about_settings.dart';
import '../../widgets/feedback_settings.dart';
import '../../widgets/general_settings.dart';

/// Class: SettingsPage
/// Function: Widget representing the Settings Page
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

/// Class: _SettingsPageState
/// Function: Returns the state of the SettingsPage widget
class _SettingsPageState extends State<SettingsPage> {
  /// Standard build function for the state of the SettingsPage widget
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Settings',
            style: TextStyle(
              color: theme.getTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return null;
            },
            child: ListView(
              children: [
                GeneralSettings(),
                FeedbackSettings(),
                AboutSettings()
              ],
            ),
          ),
        ),
      );
    });
  }
}
