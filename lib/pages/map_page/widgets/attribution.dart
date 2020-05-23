import 'package:flutter/material.dart';

import 'hyperlink.dart';

class Attribution extends StatefulWidget {
  final ThemeData theme;
  Attribution({this.theme});

  @override
  _AttributionState createState() => _AttributionState();
}

class _AttributionState extends State<Attribution> {
  @override
  Widget build(BuildContext context) {
    var attribution = <Widget>[
      Text(
        'Map tiles: ',
        style: widget.theme.textTheme.subtitle1,
      ),
      Hyperlink(
          theme: widget.theme,
          url: 'https://stamen.com/',
          text: 'Stamen Design '),
      Text(
        '(',
        style: widget.theme.textTheme.subtitle1,
      ),
      Hyperlink(
          theme: widget.theme,
          url: 'https://creativecommons.org/licenses/by/3.0/',
          text: 'CC BY 3.0'),
      Text(
        ') Data: ',
        style: widget.theme.textTheme.subtitle1,
      ),
      Hyperlink(
          theme: widget.theme,
          url: 'https://www.openstreetmap.org/',
          text: 'OpenStreetMap '),
      Text(
        '(',
        style: widget.theme.textTheme.subtitle1,
      ),
      Hyperlink(
          theme: widget.theme,
          url: 'https://www.openstreetmap.org/copyright',
          text: 'ODbL'),
      Text(
        ') ',
        style: widget.theme.textTheme.subtitle1,
      ),
    ];
    return Align(
      alignment: Alignment.bottomRight,
      child: Opacity(
          opacity: 0.9,
          child: Container(
            color: widget.theme.backgroundColor,
            width: MediaQuery.of(context).size.width * 0.9,
            child: FittedBox(
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: attribution),
            ),
          )),
    );
  }
}
