import 'package:flutter/material.dart';

class ShuttleLine extends StatelessWidget {
  final Color color;
  ShuttleLine({this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 9,
          height: 50,
          color: color,
        ),
        Container(
            child: Image.asset(
          'assets/img/stop.png',
          height: 20,
          width: 20,
        )),
        Positioned(
          child: Icon(Icons.keyboard_arrow_down,
              size: 50, color: Theme.of(context).canvasColor),
          top: 23,
        ),
        Positioned(
          child: Icon(Icons.keyboard_arrow_down,
              size: 50, color: Theme.of(context).canvasColor),
          bottom: 27,
        ),
      ],
    );
  }
}
