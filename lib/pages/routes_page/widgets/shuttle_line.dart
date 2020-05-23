import 'package:flutter/material.dart';

class ShuttleLine extends StatelessWidget {
  final Color color;
  final bool isFirst;
  final bool isLast;
  ShuttleLine({this.color, this.isFirst, this.isLast});

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
        isFirst
            ? Container()
            : Positioned(
                child: Icon(Icons.keyboard_arrow_down,
                    size: 50, color: Theme.of(context).canvasColor),
                bottom: 27,
              ),
        isLast
            ? Container()
            : Positioned(
                child: Icon(Icons.keyboard_arrow_down,
                    size: 50, color: Theme.of(context).canvasColor),
                top: 23,
              ),
      ],
    );
  }
}
