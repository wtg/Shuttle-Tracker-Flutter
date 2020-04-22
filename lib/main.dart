import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/utils/bouncing_scroll_behavior.dart';

import 'blocs/shuttle/shuttle_bloc.dart';
import 'blocs/theme/theme_bloc.dart';
import 'data/repository/shuttle_repository.dart';
import 'pages/map_page.dart';
import 'pages/schedules_page.dart';
import 'pages/settings_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _selectedTab = 0;

  final _pageOptions = [
    BlocProvider(
      create: (context) => ShuttleBloc(repository: ShuttleRepository()),
      child: MapPage(),
    ),
    SchedulesPage(),
    SettingsPage(),
  ];

  final _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.near_me),
      title: Text('Map'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list),
      title: Text('Schedules'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      title: Text('Settings'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeData>(builder: (_, theme) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            systemNavigationBarColor: theme.bottomAppBarColor,
            systemNavigationBarIconBrightness:
                theme.accentColorBrightness, //android navigation bar color
            statusBarColor: theme.bottomAppBarColor, // status bar color
            statusBarIconBrightness: theme.accentColorBrightness,
          ));
          return MaterialApp(
            builder: (context, widget) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget),
              maxWidth: 1200,
              minWidth: 430,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint(breakpoint: 450, name: MOBILE),
                ResponsiveBreakpoint(
                    breakpoint: 800, name: TABLET, autoScale: true),
                ResponsiveBreakpoint(
                    breakpoint: 1000, name: TABLET, autoScale: true),
                ResponsiveBreakpoint(breakpoint: 1200, name: DESKTOP),
                ResponsiveBreakpoint(
                    breakpoint: 2460, name: "4K", autoScale: true),
              ],
            ),
            theme: theme,
            home: SafeArea(
              top: Platform.isAndroid,
              bottom: false,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Image.asset(
                    'assets/img/logo.png',
                    height: 40,
                    width: 40,
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.red,
                  unselectedItemColor: Colors.grey,
                  currentIndex: _selectedTab,
                  onTap: (index) {
                    setState(() {
                      _selectedTab = index;
                    });
                  },
                  items: _items,
                ),
                body: IndexedStack(
                  index: _selectedTab,
                  children: _pageOptions,
                ),
              ),
            ),
          );
        }));
  }
}
