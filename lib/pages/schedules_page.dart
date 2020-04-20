import 'package:flutter/material.dart';

class SchedulesPage extends StatefulWidget {
  SchedulesPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SchedulesPageState createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Text("\n"),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 0.2,
              )),
          child: Text("\nWeekday Routes\n"),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 0.2,
              )),
          child: Text("\nNorth, South, and New West Routes\n"
              "Monday–Friday 7am – 11pm\n"),
        ),
        Container(
          color: Colors.white,
          child: Text("\n\n"),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 0.2,
              )),
          child: Text("\nWeekend Routes\n"),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 0.2,
              )),
          child: Text("\nWest and East Routes\n"
              "Saturday–Sunday 9:30am – 5pm\n\n"
              "Weekend Express Route\n"
              "Saturday–Sunday 4:30pm – 8pm\n\n"
              "Late Night Route\n"
              "Friday–Saturday 8pm – 4am\n\n"),
        ),
      ],
    ));
  }
}
