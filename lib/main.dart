import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/shuttle/shuttle_bloc.dart';
import 'blocs/theme/theme_bloc.dart';
import 'data/repository/shuttle_repository.dart';
import 'pages/map_page.dart';
import 'pages/schedules_page.dart';
import 'pages/settings_page.dart';
import 'widgets/os/android_material_app.dart';
import 'widgets/os/ios_cupertino_app.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final _pageOptions = [
    BlocProvider(
      create: (context) => ShuttleBloc(repository: ShuttleRepository()),
      child: MapPage(),
    ),
    SchedulesPage(),
    BlocProvider(
      create: (context) => ShuttleBloc(repository: ShuttleRepository()),
      child: SettingsPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeData>(builder: (_, theme) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            systemNavigationBarColor: theme.bottomAppBarColor,
            systemNavigationBarIconBrightness: theme.accentColorBrightness,
            statusBarColor: theme.bottomAppBarColor,
            statusBarIconBrightness: theme.accentColorBrightness,
          ));
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          return Platform.isIOS
              ? IOSCupertinoApp(theme: theme, pageOptions: _pageOptions)
              : AndroidMaterialApp(theme: theme, pageOptions: _pageOptions);
        }));
  }
}
