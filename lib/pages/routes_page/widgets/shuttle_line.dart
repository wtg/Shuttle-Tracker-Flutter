import 'package:flutter/material.dart';

class ShuttleLine extends StatefulWidget {
  final Color color;
  ShuttleLine({this.color});
  @override
  _ShuttleLineState createState() => _ShuttleLineState();
}

class _ShuttleLineState extends State<ShuttleLine> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 5,
          height: 50,
          color: widget.color,
        ),
        Container(
            child: Image.asset(
          'assets/img/stop.png',
          height: 15,
          width: 15,
        )),
        Positioned(
          child: Icon(Icons.keyboard_arrow_down, size: 18),
          top: 33,
        )
      ],
    );
  }
}
