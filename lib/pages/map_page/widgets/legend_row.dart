import 'package:flutter/material.dart';

/// Class: LegendRow widget
/// Function: Creates an instance of a row widget for the Legend widget class
class LegendRow extends StatelessWidget {
  final Widget widget;
  final String text;

  LegendRow({this.widget, this.text});

  /// Standard build function
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
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
