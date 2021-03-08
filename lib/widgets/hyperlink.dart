import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Hyperlink extends StatelessWidget {
  final String url;
  final String text;
  final ThemeData theme;

  Hyperlink({this.url, this.text, this.theme});

  void _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: text,
          style: TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()..onTap = _launchURL),
    );
  }
}
