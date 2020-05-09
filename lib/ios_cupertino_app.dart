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
      icon: Icon(Icons.map),
      title: Text('Routes'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list),
      title: Text('Schedules'),
    ),
    BottomNavigationBarItem(
      icon: Icon(IconData(0xf43d,
          fontFamily: 'CupertinoIcons',
          fontPackage: 'cupertino_icons',
          matchTextDirection: true)),
      title: Text('Settings'),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: widget.theme,
      child: CupertinoApp(
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
                return CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      padding: EdgeInsetsDirectional.only(bottom: 10),
                      backgroundColor: widget.theme.appBarTheme.color,
                      middle: Image.asset(
                        'assets/img/logo.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                    child: widget.pageOptions[i]);
              },
            );
          },
        ),
      ),
    );
  }
}
