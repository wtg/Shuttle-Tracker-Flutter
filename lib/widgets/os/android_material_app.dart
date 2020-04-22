import 'package:flutter/material.dart';

class AndroidMaterialApp extends StatefulWidget {
  final ThemeData theme;

  final pageOptions;

  AndroidMaterialApp({this.theme, this.pageOptions});

  @override
  _AndroidMaterialAppState createState() => _AndroidMaterialAppState();
}

class _AndroidMaterialAppState extends State<AndroidMaterialApp> {
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: widget.theme,
      home: SafeArea(
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
            children: widget.pageOptions,
          ),
        ),
      ),
    );
  }
}