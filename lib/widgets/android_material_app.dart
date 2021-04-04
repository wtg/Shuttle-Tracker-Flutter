import 'package:flutter/material.dart';
import 'package:flutter_shuttletracker/blocs/theme_bloc/theme_bloc.dart';
import '../icons/shuttle_icon.dart';
import 'package:provider/provider.dart';

class AndroidMaterialApp extends StatefulWidget {
  final List<Widget> pageOptions;

  AndroidMaterialApp({this.pageOptions});

  @override
  _AndroidMaterialAppState createState() => _AndroidMaterialAppState();
}

class _AndroidMaterialAppState extends State<AndroidMaterialApp> {
  int _selectedTab = 0;
  final _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.near_me),
      label: 'Map',
    ),
    BottomNavigationBarItem(
      icon: Icon(ShuttleIcon.logo),
      label: 'Routes',
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: SafeArea(
        bottom: false,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: theme.appBarTheme.color,
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
