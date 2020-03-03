import 'package:flutter/material.dart';
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
    final _pageOptions = [
        MapPage(),
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
                )
            ),
            home: SafeArea( 
                child: Scaffold(
                    appBar: AppBar(
                        backgroundColor: Colors.white,
                        title: Image(
                            image: ExactAssetImage('assets/img/icon.png'),
                            height: 40,
                            width: 500,
                            // Come back to this section I think I did this wrong
                            // yet it kinda works 
                        ),
                    ),
                    
                    body: _pageOptions[_selectedTab], 
                    bottomNavigationBar: BottomNavigationBar(
                        currentIndex: _selectedTab,
                        onTap: (int index) {
                            setState(() {
                                _selectedTab = index;
                            });
                        },
                        items: [
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
                        ],
                    )
                ),
            ),
        );
    }
}