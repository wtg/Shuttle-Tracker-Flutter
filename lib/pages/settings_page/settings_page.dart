import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/theme/theme_bloc.dart';
import 'widgets/android_settings.dart';
import 'widgets/ios_settings.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Settings',
            style: TextStyle(
              color: theme.getTheme.hoverColor,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        body: Material(
          child: Center(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
                return null;
              },
              child: Platform.isIOS
                  ? IOSSetttings(theme: theme)
                  : AndroidSettings(theme: theme),
            ),
          ),
        ),
      );
    });
  }
}
