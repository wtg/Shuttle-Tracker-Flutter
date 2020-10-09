import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../blocs/theme_bloc/theme_bloc.dart';

class PrivacyPolicyPage extends StatelessWidget {
  final ThemeState theme;
  PrivacyPolicyPage({this.theme});

  void _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  TextSpan buildHyperlink(String link, String placeholder) {
    return TextSpan(
      text: placeholder,
      style: TextStyle(
        color: Colors.blue,
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          _launch(link);
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    var _subHeader = TextStyle(
      color: theme.getTheme.hoverColor,
    );

    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: Container(
          color: theme.getTheme.appBarTheme.color,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            color: theme.getTheme.hoverColor,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        title: Text(
          'Privacy Policy',
          style: TextStyle(
            color: theme.getTheme.hoverColor,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: theme.getTheme.appBarTheme.color,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Shuttle Tracker is operated by the ',
                    style: _subHeader),
                buildHyperlink(
                    'https://webtech.union.rpi.edu', 'Web Technolgies Group'),
                TextSpan(
                    text: ' (WebTech), a committee of the Rensselaer Union '
                        'Student Senate. WebTech uses Google Analytics to'
                        ' gather anonymous metrics about the users of its '
                        'services. This information cannot and will not be '
                        'used to identify you or any specific user'
                        ' of the service.',
                    style: _subHeader),
              ]),
            ),
            SizedBox(
              height: 20.0,
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'If you grant permission for Shuttle Tracker to '
                        'access your location, this information is used '
                        'for two purposes. The first is to indicate your '
                        'location on the map. The second is to enhance the '
                        'accuracy of vehicle tracking. The information '
                        'Shuttle Tracker gathers is limited to your '
                        "device's latitude, longitude, speed, and heading. "
                        'These data are associated with a random identifier'
                        ' that is generated whenever you open Shuttle '
                        'Tracker. In order to protect your privacy, no '
                        'two visits to Shuttle Tracker are associated. '
                        'This identifier is not used to identify any '
                        'specific user of the service. All data gathered'
                        ' are only analyzed in aggregate in order to '
                        'improve the quality of vehicle tracking for all'
                        ' users.',
                    style: _subHeader),
              ]),
            ),
            SizedBox(height: 20.0),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Any questions about this privacy policy should be '
                        'directed to ',
                    style: _subHeader),
                buildHyperlink('mailto:webtech@union.lists.rpi.edu',
                    'webtech@union.lists.rpi.edu'),
                TextSpan(text: '.', style: _subHeader),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
