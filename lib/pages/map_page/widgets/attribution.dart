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
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Hyperlink(url: 'https://stamen.com/', text: 'Stamen Design '),
        Text(
          '(',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Hyperlink(
            url: 'https://creativecommons.org/licenses/by/3.0/',
            text: 'CC BY 3.0'),
        Text(
          ') Data: ',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Hyperlink(
            url: 'https://www.openstreetmap.org/', text: 'OpenStreetMap '),
        Text(
          '(',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Hyperlink(url: 'https://www.openstreetmap.org/copyright', text: 'ODbL'),
        Text(
          ') ',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ];
      return Align(
        alignment: Alignment.bottomRight,
        child: Opacity(
            opacity: 0.9,
            child: Container(
              color: Theme.of(context).backgroundColor,
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
