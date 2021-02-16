import 'package:flutter/material.dart';

import '../../../blocs/theme_bloc/theme_bloc.dart';
import 'about_settings.dart';
import 'feedback_settings.dart';
import 'general_settings.dart';

/// Class: AndroidSettings
/// Function: Returns the Settings Page layout for Android software
class AndroidSettings extends StatefulWidget {
  final ThemeState theme;
  AndroidSettings({this.theme});

  @override
  _AndroidSettingsState createState() => _AndroidSettingsState();
}

/// Class: _AndroidSettingsState
/// Function: Returns the state of the widget/layout
class _AndroidSettingsState extends State<AndroidSettings> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        GeneralSettings(theme: widget.theme),
        FeedbackSettings(theme: widget.theme),
        AboutSettings(theme: widget.theme)
      ],
    );
  }
}
