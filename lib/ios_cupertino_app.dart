import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'icons/shuttle_icon.dart';

class IOSCupertinoApp extends StatefulWidget {
  final ThemeData theme;

  final List<Widget> pageOptions;

  IOSCupertinoApp({this.theme, this.pageOptions});

  @override
  _IOSCupertinoAppState createState() => _IOSCupertinoAppState();
}

class _IOSCupertinoAppState extends State<IOSCupertinoApp> {
  int _selectedTab = 0;
  final _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.near_me),
      label: 'Map',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        ShuttleIcon.logo,
        size: 20,
      ),
      label: 'Routes',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: widget.theme,
      child: CupertinoApp(
        theme: CupertinoThemeData(
          brightness: widget.theme.brightness,
        ),
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 370,
          defaultScale: true,
        ),
        home: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            iconSize: 25.0,
            activeColor: Colors.red,
            backgroundColor: widget.theme.appBarTheme.color,
            items: _items,
            currentIndex: _selectedTab,
            onTap: (index) {
              setState(() {
                _selectedTab = index;
              });
            },
          ),
          tabBuilder: (context, i) {
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(child: widget.pageOptions[i]);
              },
            );
          },
        ),
      ),
    );
  }
}
