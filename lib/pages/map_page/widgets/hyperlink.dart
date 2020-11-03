import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Class: Hyperlink widget
/// Function: Creates an instance of a hyperlink widget
class Hyperlink extends StatelessWidget {
  final String url;
  final String text;
  final ThemeData theme;

  Hyperlink({this.url, this.text, this.theme});

  /// Redirects/Launches the link to the URL/website
  void _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// Standard build function for the widget
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        text,
        style: TextStyle(
            color: Colors.blue, fontSize: theme.textTheme.subtitle1.fontSize),
      ),
      onTap: _launchURL,             // When link is tapped, redirect to the URL
    );
  }
}
