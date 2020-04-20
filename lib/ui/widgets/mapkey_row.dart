import 'package:flutter/material.dart';

class MapkeyRow extends StatelessWidget {
  final Widget widget;
  final String text;

  MapkeyRow({this.widget, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 13,
          height: 13,
          child: widget,
        ),
        Text(
          text,
        ),
      ],
    );
  }
}
