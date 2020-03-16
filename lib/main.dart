import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shuttletracker/bloc/shuttle_bloc.dart';
import 'package:flutter_shuttletracker/data/repository/ShuttleRepository.dart';
import './pages/MapPage.dart';
import './pages/SchedulesPage.dart';
import './pages/SettingsPage.dart';
import 'dart:ui';

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
      create: (context) => ShuttleBloc(ShuttleRepository()),
      child: MapPage(),
    ),
    SchedulesPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.red,
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.white),
          )),
      home: SafeArea(
        child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Image.asset(
                  'assets/img/icon.png',
                  height: 40,
                  width: 40,
                )),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedTab,
              onTap: (int index) {
                setState(() {
                  _selectedTab = index;
                });
              },
              items: _items,
            ),
            body: IndexedStack(
              index: _selectedTab,
              children: _pageOptions,
            )),
      ),
    );
  }
}
