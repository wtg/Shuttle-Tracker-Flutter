import 'package:flutter/material.dart';

class DarkModeText extends StatelessWidget {
  final String text;
  final bool isDarkMode;

  DarkModeText({this.text, this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black, fontSize: 11.0),
    );
  }
}
