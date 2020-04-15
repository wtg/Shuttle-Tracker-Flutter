import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/utils/bouncing_scroll_behavior.dart';

import 'bloc/shuttle_bloc.dart';
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
    
    return PlatformApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget),
        maxWidth: 1200,
        minWidth: 430,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint(breakpoint: 450, name: MOBILE),
          ResponsiveBreakpoint(breakpoint: 800, name: TABLET, autoScale: true),
          ResponsiveBreakpoint(breakpoint: 1000, name: TABLET, autoScale: true),
          ResponsiveBreakpoint(breakpoint: 1200, name: DESKTOP),
          ResponsiveBreakpoint(breakpoint: 2460, name: "4K", autoScale: true),
        ],
      ),
      android: (_) => MaterialAppData(
        theme: ThemeData(
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.black),
          ),
          primarySwatch: Colors.red,
          appBarTheme:
              AppBarTheme(color: Colors.white, brightness: Brightness.light),
        ),
        darkTheme: ThemeData(
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.white),
          ),
          canvasColor: Colors.black,
          primarySwatch: Colors.red,
          appBarTheme: AppBarTheme(color: Colors.black),
        ),
      ),
      // TODO: ADD IOS PARAMETER
      home: SafeArea(
        top: Platform.isAndroid,
        bottom: false,
        child: PlatformScaffold(
          appBar: PlatformAppBar(
              android: (_) => MaterialAppBarData(
                    centerTitle: true,
                  ),
              // TODO: ADD IOS PARAMETER
              title: Image.asset(
                'assets/img/logo.png',
                height: 40,
                width: 40,
              )),
          bottomNavBar: PlatformNavBar(
            android: (_) => MaterialNavBarData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.grey,
              currentIndex: _selectedTab,
              itemChanged: (index) {
                setState(() {
                  _selectedTab = index;
                });
              },
            ),
            items: _items,
            // TODO: ADD IOS PARAMETER
          ),
          body: IndexedStack(
            index: _selectedTab,
            children: _pageOptions,
          ),
        ),
      ),
    );
  }
}
