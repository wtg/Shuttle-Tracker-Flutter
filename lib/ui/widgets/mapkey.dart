import 'package:flutter/material.dart';
import '../../models/shuttle_image.dart';

import 'mapkey_row.dart';

class Mapkey extends StatefulWidget {
  final bool isDarkMode;
  final Map<String, ShuttleImage> mapkey;

  Mapkey({this.isDarkMode, this.mapkey});

  @override
  _MapkeyState createState() => _MapkeyState();
}

class _MapkeyState extends State<Mapkey> {
  @override
  Widget build(BuildContext context) {
    var mapkeyRows = <Widget>[
      MapkeyRow(
          widget: Image.asset('assets/img/user.png'),
          text: ' You',
          isDarkMode: widget.isDarkMode),
    ];
    widget.mapkey.forEach((key, value) {
      mapkeyRows.add(MapkeyRow(
          widget: value.getSVG, text: " $key", isDarkMode: widget.isDarkMode));
    });
    mapkeyRows.add(MapkeyRow(
        widget: Image.asset('assets/img/circle.png'),
        text: ' Shuttle Stop',
        isDarkMode: widget.isDarkMode));
    print("Number of rows in mapkey: ${mapkeyRows.length}\n\n");
    return Positioned(
      bottom: 40,
      left: 10,
      child: Opacity(
        opacity: 0.90,
        child: Container(
          decoration: BoxDecoration(
              color: widget.isDarkMode ? Colors.grey[900] : Colors.white,
              border: Border.all(
                width: 5,
                color: widget.isDarkMode
                    ? Colors.black.withOpacity(0.1)
                    : Colors.white.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                    offset: Offset(0.0, 0.5))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: mapkeyRows,
          ),
        ),
      ),
    );
  }
}
