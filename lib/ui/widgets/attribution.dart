import 'package:flutter/material.dart';

import 'hyperlink.dart';

class Attribution extends StatefulWidget {
  Attribution();

  @override
  _AttributionState createState() => _AttributionState();
}

class _AttributionState extends State<Attribution> {
  @override
  Widget build(BuildContext context) {
    var attribution = <Widget>[
      Text(
        'Map tiles: ',
        style: TextStyle(fontSize: 11.0),
      ),
      Hyperlink(url: 'https://stamen.com/', text: 'Stamen Design '),
      Text(
        '(',
        style: TextStyle(fontSize: 11.0),
      ),
      Hyperlink(
          url: 'https://creativecommons.org/licenses/by/3.0/',
          text: 'CC BY 3.0'),
      Text(
        ') Data:',
        style: TextStyle(fontSize: 11.0),
      ),
      Hyperlink(url: 'https://www.openstreetmap.org/', text: 'OpenStreetMap '),
      Text(
        '(',
        style: TextStyle(fontSize: 11.0),
      ),
      Hyperlink(url: 'https://www.openstreetmap.org/copyright', text: 'ODbL'),
      Text(
        ')',
        style: TextStyle(fontSize: 11.0),
      ),
    ];
    return Align(
      alignment: Alignment.bottomRight,
      child: Opacity(
          opacity: 0.90,
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: attribution),
          )),
    );
  }
}
