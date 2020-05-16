import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
      return PlatformScaffold(
        appBar: PlatformAppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Settings',
            style: TextStyle(color: Theme.of(context).hoverColor),
          ),
          backgroundColor: Theme.of(context).appBarTheme.color,
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
                : AndroidSettings(theme: theme)
          )),
        ),
      );
    });
  }
}