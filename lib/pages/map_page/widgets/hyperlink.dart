import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Hyperlink extends StatelessWidget {
  final String url;
  final String text;

  Hyperlink({this.url, this.text});

  void _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {

      return InkWell(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.blue,
              fontSize: Theme.of(context).textTheme.subtitle1.fontSize),
        ),
        onTap: _launchURL,
      );
  }
}
