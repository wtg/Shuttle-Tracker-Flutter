import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
      icon: Icon(Icons.navigation),
      title: Text('Map'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.directions_bus),
      title: Text('Routes'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.time),
      title: Text('Schedules'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.gear_solid),
      title: Text('Settings'),
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
