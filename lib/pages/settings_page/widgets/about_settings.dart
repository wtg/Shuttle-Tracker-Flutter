import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../blocs/theme/theme_bloc.dart';
import 'faq_detail.dart';
import 'privacy_detail.dart';
import 'sockets_test.dart';

class AboutSettings extends StatefulWidget {
  final ThemeState theme;
  AboutSettings({this.theme});

  @override
  _AboutSettingsState createState() => _AboutSettingsState();
}

class _AboutSettingsState extends State<AboutSettings> {
//  int devSettings = 0;

  @override
  Widget build(BuildContext context) {
    var aboutSettingsList = <Widget>[
      ListTile(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'FAQ',
              style: TextStyle(
                  color: widget.theme.getTheme.hoverColor, fontSize: 16),
            ),
            Text(
              'View frequently asked questions',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FaqPage(
                        theme: widget.theme,
                      )));
        },
      ),
      ListTile(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'GitHub Repo',
              style: TextStyle(
                  color: widget.theme.getTheme.hoverColor, fontSize: 16),
            ),
            Text(
              'Interested in contributing? Check out our repo!',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        onTap: () async {
          var url = 'https://github.com/wtg/Flutter_ShuttleTracker';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
      ),
      ListTile(
        dense: true,
        leading: Text(
          'Privacy Policy',
          style:
              TextStyle(color: widget.theme.getTheme.hoverColor, fontSize: 16),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PrivacyPolicyPage(
                        theme: widget.theme,
                      )));
        },
      ),
      ListTile(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Version',
              style: TextStyle(
                  color: widget.theme.getTheme.hoverColor, fontSize: 16),
            ),
            Text(
              '1.0.0',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SocketTest()));
          // This was just to play around with some stuff, can add more later
//          setState(() {
//            devSettings++;
//            if (devSettings < 10) {
//              Toast.show(
//                "You are ${10 - devSettings} "
//                    "steps away from being a developer!",
//                context,
//                duration: Toast.LENGTH_LONG,
//                gravity: Toast.BOTTOM,
//              );
//            }
//
//          });
//          if (devSettings >= 10) {
//            Navigator.push(
//              context, MaterialPageRoute(builder: (context) => SocketTest()));
//          }
        },
      ),
    ];
    return Column(
      children: <Widget>[
        ListTile(
          dense: true,
          leading: Text(
            'About',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
        ),
        NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return null;
          },
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: aboutSettingsList.length,
            itemBuilder: (context, index) => aboutSettingsList[index],
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey[600],
                height: 4,
                indent: 15.0,
              );
            },
          ),
        )
      ],
    );
  }
}
