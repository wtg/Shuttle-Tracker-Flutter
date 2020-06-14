import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Hyperlink extends StatelessWidget {
  final String url;
  final String text;
  final Color color;
  final ThemeData theme;

  Hyperlink({this.url, this.text, this.theme, this.color});

  void _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

//  TextSpan buildHyperlinks(BuildContext context) {
//    return TextSpan(
//        text: text,
//        style: TextStyle(color: color),
//        recognizer: TapGestureRecognizer()..onTap = _launchURL);
//  }
//
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text,
          style: TextStyle(color: color),
          recognizer: TapGestureRecognizer()..onTap = _launchURL),
    );
  }
}
