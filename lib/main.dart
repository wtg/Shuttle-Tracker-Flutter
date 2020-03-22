import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shuttletracker/bloc/shuttle_bloc.dart';
import 'package:flutter_shuttletracker/data/repository/ShuttleRepository.dart';
import './pages/MapPage.dart';
import './pages/SchedulesPage.dart';
import './pages/SettingsPage.dart';
import 'dart:ui';
import 'dart:io';

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
      theme: ThemeData(
        primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.black),
        ),
        primarySwatch: Colors.red,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          brightness: Brightness.light
        ),
      ),
      darkTheme: ThemeData(
        primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.white),
        ),
        canvasColor: Colors.black,
        primarySwatch: Colors.red,
        appBarTheme: AppBarTheme(
          color: Colors.black
        ),
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
          ),
        ),
      ),
    );
  }
}
