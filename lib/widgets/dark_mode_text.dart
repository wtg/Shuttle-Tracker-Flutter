import 'package:flutter/material.dart';

class IsDarkModeText extends StatelessWidget {
  final String _text;
  final bool _isDarkMode;

  IsDarkModeText(this._text, this._isDarkMode);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
    );
  }
}
