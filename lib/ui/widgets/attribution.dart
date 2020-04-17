import 'package:flutter/material.dart';

import 'hyperlink.dart';

class Attribution extends StatelessWidget {
  final bool isDarkMode;

  final List<Widget> attribution = [
    Text('Map tiles: '),
    Hyperlink(url: 'https://stamen.com/', text: 'Stamen Design '),
    Text('('),
    Hyperlink(
        url: 'https://creativecommons.org/licenses/by/3.0/', text: 'CC BY 3.0'),
    Text(') Data:'),
    Hyperlink(url: 'https://www.openstreetmap.org/', text: 'OpenStreetMap '),
    Text('('),
    Hyperlink(url: 'https://www.openstreetmap.org/copyright', text: 'ODbL'),
    Text(')'),
  ];

  Attribution({this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Opacity(
          opacity: 0.90,
          child: Container(
            color: isDarkMode ? Colors.grey[900] : Colors.white,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: attribution),
          )),
    );
  }
}
