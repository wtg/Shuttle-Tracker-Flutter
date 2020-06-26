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
    var attribution1 = <Widget>[
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
        ')',
        style: widget.theme.textTheme.subtitle1,
      ),
    ];

    var attribution2 = <Widget>[
      Text(
        'Data: ',
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
        ')',
        style: widget.theme.textTheme.subtitle1,
      ),
    ];

    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Opacity(
          opacity: 1.0,
          child: Container(
            decoration: BoxDecoration(
                color: widget.theme.backgroundColor,
                borderRadius: BorderRadius.circular(8.0)),
            padding: const EdgeInsets.all(5.0),
            width: MediaQuery.of(context).size.width * 0.4,
            child: FittedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: attribution1,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: attribution2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
