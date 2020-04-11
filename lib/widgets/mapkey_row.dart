import 'package:flutter/material.dart';

class MapkeyRow extends StatelessWidget {
  final Widget widget;
  final String text;
  final bool isDarkMode;

  MapkeyRow({this.widget, this.text, this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          child: widget,
        ),
        Text(
          text,
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
      ],
    );
  }
}
