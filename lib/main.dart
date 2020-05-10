import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'android_material_app.dart';
import 'blocs/shuttle/shuttle_bloc.dart';
import 'blocs/theme/theme_bloc.dart';
import 'data/repository/shuttle_repository.dart';
import 'ios_cupertino_app.dart';
import 'pages/map_page/map_page.dart';
import 'pages/routes_page/routes_page.dart';
import 'pages/schedules_page/schedules_page.dart';
import 'pages/settings_page/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = await HydratedBlocDelegate.build();
  return runApp(MyApp());
}

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
    BlocProvider(
        create: (context) => ShuttleBloc(repository: ShuttleRepository()),
        child: RoutesPage()),
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
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: (_, theme) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            systemNavigationBarColor: theme.getTheme.bottomAppBarColor,
            systemNavigationBarIconBrightness:
                theme.getTheme.accentColorBrightness,
            statusBarColor: theme.getTheme.bottomAppBarColor,
            statusBarIconBrightness: theme.getTheme.accentColorBrightness,
          ));
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
          return Platform.isIOS
              ? IOSCupertinoApp(
                  theme: theme.getTheme, pageOptions: _pageOptions)
              : AndroidMaterialApp(
                  theme: theme.getTheme, pageOptions: _pageOptions);
        }));
  }
}
