import 'package:flutter/material.dart';

class MapkeyRow extends StatelessWidget {
  final Widget _widget;
  final String _text;
  final bool _isDarkMode;

  MapkeyRow(this._widget, this._text, this._isDarkMode);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          child: _widget,
        ),
        Text(
          _text,
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
      ],
    );
  }
}
