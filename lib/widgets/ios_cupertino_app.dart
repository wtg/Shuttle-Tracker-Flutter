import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shuttletracker/blocs/theme_bloc/theme_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:provider/provider.dart';
import '../icons/shuttle_icon.dart';

class IOSCupertinoApp extends StatefulWidget {
  final List<Widget> pageOptions;

  IOSCupertinoApp({this.pageOptions});

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
      icon: Icon(Icons.access_time),
      label: 'Schedules',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    )
  ];

  @override
  Widget build(BuildContext context) {
    var themeBloc = context.watch<ThemeBloc>();
    var theme = themeBloc.state.getTheme;
    return Theme(
      data: theme,
      child: CupertinoApp(
        theme: CupertinoThemeData(
          brightness: theme.brightness,
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
            backgroundColor: theme.appBarTheme.color,
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
