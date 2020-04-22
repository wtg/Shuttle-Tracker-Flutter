import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorMap extends StatefulWidget {
  final String message;

  ErrorMap({this.message});

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
          ),
        ),
      ],
    );
  }
}
