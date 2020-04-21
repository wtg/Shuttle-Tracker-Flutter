import 'package:flutter/material.dart';

class ShuttleDrawer extends StatelessWidget {
  final Function onTap;

  ShuttleDrawer({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      DrawerHeader(
        child: Text('Drawer Header'),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
      ListTile(
        leading: Icon(Icons.near_me),
        title: Text('Map'),
        onTap: () => onTap(context, 0),
      ),
      ListTile(
        leading: Icon(Icons.list),
        title: Text('Schedules'),
        onTap: () => onTap(context, 1),
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings'),
        onTap: () => onTap(context, 2),
      ),
    ]));
  }
}
