import 'package:flutter/material.dart';

import 'dark_mode_text.dart';
import 'hyperlink.dart';

class Attribution extends StatefulWidget {
  final bool isDarkMode;

  Attribution({this.isDarkMode});

  @override
  _AttributionState createState() => _AttributionState();
}

class _AttributionState extends State<Attribution> {
  @override
  Widget build(BuildContext context) {
    var attribution = <Widget>[
      DarkModeText(
        text: 'Map tiles: ',
        isDarkMode: widget.isDarkMode,
      ),
      Hyperlink(url: 'https://stamen.com/', text: 'Stamen Design '),
      DarkModeText(
        text: '(',
        isDarkMode: widget.isDarkMode,
      ),
      Hyperlink(
          url: 'https://creativecommons.org/licenses/by/3.0/',
          text: 'CC BY 3.0'),
      DarkModeText(
        text: ') Data:',
        isDarkMode: widget.isDarkMode,
      ),
      Hyperlink(url: 'https://www.openstreetmap.org/', text: 'OpenStreetMap '),
      DarkModeText(
        text: '(',
        isDarkMode: widget.isDarkMode,
      ),
      Hyperlink(url: 'https://www.openstreetmap.org/copyright', text: 'ODbL'),
      DarkModeText(
        text: ')',
        isDarkMode: widget.isDarkMode,
      ),
    ];
    return Align(
      alignment: Alignment.bottomRight,
      child: Opacity(
          opacity: 0.90,
          child: Container(
            color: widget.isDarkMode ? Colors.grey[900] : Colors.white,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: attribution),
          )),
    );
  }
}
