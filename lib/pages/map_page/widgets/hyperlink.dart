import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../blocs/theme/theme_bloc.dart';

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
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
      return InkWell(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.blue,
              fontSize: theme.getTheme.textTheme.subtitle1.fontSize),
        ),
        onTap: _launchURL,
      );
    });
  }
}
