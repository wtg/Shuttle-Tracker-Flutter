import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'blocs/fusion_bloc/fusion_bloc.dart';
import 'blocs/map_bloc/map_bloc.dart';
import 'blocs/on_tap_bloc/on_tap_bloc.dart';
import 'blocs/routes_bloc/routes_bloc.dart';
import 'blocs/theme_bloc/theme_bloc.dart';
import 'data/fusion/fusion_socket.dart';
import 'data/repository/shuttle_repository.dart';
import 'pages/map_page/map_page.dart';
import 'pages/routes_page/routes_page.dart';
import 'pages/settings_page/settings_page.dart';
import 'widgets/android_material_app.dart';
import 'widgets/ios_cupertino_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();
  return runApp(MyApp()
      // DevicePreview(
      //     enabled: false, //!kReleaseMode,
      //     builder: (context) => MyApp()),
      );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final _pageOptions = [
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MapBloc(repository: ShuttleRepository()),
        ),
        BlocProvider(
          create: (context) => OnTapBloc(),
        ),
        BlocProvider(
          create: (context) => FusionBloc(fusionSocket: FusionSocket()),
        )
      ],
      child: MapPage(),
    ),
    BlocProvider(
        create: (context) => RoutesBloc(repository: ShuttleRepository()),
        child: RoutesPage()),
    BlocProvider(
      create: (context) => RoutesBloc(repository: ShuttleRepository()),
      child: SettingsPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: (_, theme) {
          services.SystemChrome.setSystemUIOverlayStyle(
              services.SystemUiOverlayStyle(
            systemNavigationBarColor: theme.getTheme.bottomAppBarColor,
            systemNavigationBarIconBrightness:
                theme.getTheme.accentColorBrightness,
            statusBarColor: theme.getTheme.bottomAppBarColor,
            statusBarIconBrightness: theme.getTheme.accentColorBrightness,
          ));
          services.SystemChrome.setPreferredOrientations([
            services.DeviceOrientation.portraitUp,
          ]);
          return Platform.isIOS
              ? IOSCupertinoApp(
                  theme: theme.getTheme, pageOptions: _pageOptions)
              : AndroidMaterialApp(
                  theme: theme.getTheme, pageOptions: _pageOptions);
        }));
  }
}
