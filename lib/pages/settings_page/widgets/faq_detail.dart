import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../blocs/theme_bloc/theme_bloc.dart';

class FaqPage extends StatelessWidget {
  final ThemeState theme;
  FaqPage({this.theme});

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
      style: TextStyle(color: Colors.blue),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          _launch(link);
        },
    );
  }

  Widget buildEntry(String head, RichText body) {
    var _mainHeader = TextStyle(
      color: theme.getTheme.accentColor,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            head,
            style: _mainHeader,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: body,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var _subHeader = TextStyle(
      color: theme.getTheme.hoverColor,
    );

    var faqList = <Widget>[
      buildEntry(
        'What is Shuttle Tracker?',
        RichText(
          text: TextSpan(children: [
            TextSpan(text: 'Shuttle Tracker is ', style: _subHeader),
            buildHyperlink(
                'https://github.com/wtg/shuttletracker', 'open source'),
            TextSpan(text: ' and maintained by the ', style: _subHeader),
            buildHyperlink(
                'https://webtech.union.rpi.edu', 'Web Technologies Group'),
            TextSpan(
                text: ' of the Rensselaer Union Student Senate for '
                    'the benefit of the student body.\n'
                    'It is also an active ',
                style: _subHeader),
            buildHyperlink('https://rcos.io', 'RCOS'),
            TextSpan(
                text: ' project, and over 50 students have '
                    'contributed to it through RCOS in previous semesters.',
                style: _subHeader),
          ]),
        ),
      ),
      buildEntry(
        'Why is there no app?',
        RichText(
          text: TextSpan(children: [
            TextSpan(text: 'What do you mean? ahaha', style: _subHeader),
          ]),
        ),
      ),
      buildEntry(
        'Why are there shuttles in downtown Troy?',
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'The shuttle station is located in downtown Troy.'
                    ' As shuttles are driving to'
                    ' and from the station each day, '
                    'they are still being tracked.\n'
                    'These are the shuttles you see in downtown Troy.',
                style: _subHeader),
          ]),
        ),
      ),
      buildEntry(
        'Why are the shuttles the wrong color?',
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'Since both the shuttles and routes '
                    'change on a daily basis,'
                    " a shuttle's route is determined "
                    'dynamically by looking at '
                    'which route it has been closest to'
                    'recently. However, due to '
                    'routes overlapping and drivers going'
                    " on break or off-course, a shuttle's "
                    'route may be incorrectly '
                    'determined. This '
                    'should resolve itself within a few minutes,'
                    ' however if there '
                    'are repeated issues feel free to send us a message.',
                style: _subHeader),
          ]),
        ),
      ),
      buildEntry(
        'Why are some shuttles colored white?',
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'If shuttles are off-route for multiple minutes, '
                    'their color will change to a white color to indicate '
                    'they are no longer on a route.',
                style: _subHeader),
          ]),
        ),
      ),
      buildEntry(
        'Why do the shuttles jump on the map?',
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'When the shuttle is traveling at a certain speed '
                    'for 8 seconds, the shuttle location will update.',
                style: _subHeader),
          ]),
        ),
      ),
//      SizedBox(
//        height: 10.0,
//      ),
      buildEntry(
        'Why did the routes change?',
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'Parking and Transportation,'
                    ' along with some Senate committees, '
                    'updated the routes (beginning Spring 2020) to make '
                    'them faster'
                    ' and serve more students '
                    '(most notably by cutting the East route into two'
                    ' different routes). '
                    'More information can be found ',
                style: _subHeader),
            buildHyperlink('https://shuttles.rpi.edu/changes', 'here'),
            TextSpan(text: '.', style: _subHeader),
          ]),
        ),
      ),
      buildEntry(
        'How can I contribute?',
        RichText(
          text: TextSpan(children: [
            TextSpan(text: 'We have an active ', style: _subHeader),
            buildHyperlink(
                'https://github.com/wtg/shuttletracker', 'repository'),
            TextSpan(
                text: ' on GitHub where we track'
                    ' issues and accept pull requests. '
                    'Learn more about what we do on our ',
                style: _subHeader),
            buildHyperlink('https://webtech.union.rpi.edu', 'website'),
            TextSpan(text: ' or by sending us an ', style: _subHeader),
            buildHyperlink('mailto:webtech@union.lists.rpi.edu', 'email'),
            TextSpan(text: '.', style: _subHeader),
          ]),
        ),
      ),
      buildEntry(
        'Why are the shuttles spewing buses and other emojis?',
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'The beloved 𝐵𝓊𝓈 𝐵𝓊𝓉𝓉𝑜𝓃 can be used for'
                    ' a variety of reasons. '
                    'You can press the 𝐵𝓊𝓈 𝐵𝓊𝓉𝓉𝑜𝓃 to let'
                    ' people know where a '
                    'shuttle is, how fast you’re going,'
                    ' or to assert your dominance.',
                style: _subHeader),
          ]),
        ),
      ),
      buildEntry(
        'How do you pronounce "track?"',
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: '“Tra-cc”,'
                    " it's pretty straightforward.",
                style: _subHeader),
          ]),
        ),
      ),
    ];
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
          'FAQ',
          style: TextStyle(
            color: theme.getTheme.hoverColor,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: theme.getTheme.appBarTheme.color,
      ),
//        body: ListView.builder(
//            itemCount: faqList.length,
//            itemBuilder: (context, index) => faqList[index])

      body: ListView.separated(
//        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: faqList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: faqList[index],
        ),
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[700],
            height: 4,
          );
        },
      ),
    );
  }
}
