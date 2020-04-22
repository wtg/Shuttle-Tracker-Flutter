import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  final Function onTap;
  static const url = 'https://github.com/wtg/Flutter_ShuttleTracker';
  CustomDrawer({this.onTap});

  _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      DrawerHeader(
        child: Center(
          child: Image.asset(
            'assets/img/logo.png',
            height: 100,
            width: 100,
          ),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.color,
        ),
      ),
      ListTile(
        leading: Icon(
          Icons.near_me,
          color: Theme.of(context).hoverColor,
        ),
        title: Text('Map',
            style: TextStyle(
              color: Theme.of(context).hoverColor,
            )),
        onTap: () => onTap(context, 0),
      ),
      ListTile(
        leading: Icon(
          Icons.list,
          color: Theme.of(context).hoverColor,
        ),
        title: Text('Schedules',
            style: TextStyle(
              color: Theme.of(context).hoverColor,
            )),
        onTap: () => onTap(context, 1),
      ),
      ListTile(
        leading: Icon(
          Icons.settings,
          color: Theme.of(context).hoverColor,
        ),
        title: Text('Settings',
            style: TextStyle(
              color: Theme.of(context).hoverColor,
            )),
        onTap: () => onTap(context, 2),
      ),
      ListTile(
        leading: Icon(
          Icons.cloud_download,
          color: Theme.of(context).hoverColor,
        ),
        title: Text('GitHub Repo',
            style: TextStyle(
              color: Theme.of(context).hoverColor,
            )),
        onTap: () => _launchURL(),
      ),
    ]));
  }
}
