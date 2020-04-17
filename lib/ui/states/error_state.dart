import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorMap extends StatefulWidget {
  final String message;
  final bool isDarkMode;

  ErrorMap({this.message, this.isDarkMode});

  @override
  _ErrorMapState createState() => _ErrorMapState();
}

class _ErrorMapState extends State<ErrorMap> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            widget.message,
            style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black),
          ),
        ),
      ],
    );
  }
}
