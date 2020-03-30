import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/utils/bouncing_scroll_behavior.dart';

import './pages/MapPage.dart';
import './pages/SchedulesPage.dart';
import './pages/SettingsPage.dart';
import 'bloc/shuttle_bloc.dart';
import 'data/repository/ShuttleRepository.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _selectedTab = 0;
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

  final _pageOptions = [
    BlocProvider(
      create: (context) => ShuttleBloc(repository: ShuttleRepository()),
      child: MapPage(),
    ),
    SchedulesPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: SafeArea(
        top: Platform.isAndroid,
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: Image.asset(
                'assets/img/icon.png',
                height: 40,
                width: 40,
              )),
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
  }
}
