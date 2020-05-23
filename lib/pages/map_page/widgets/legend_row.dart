import 'package:flutter/material.dart';

class LegendRow extends StatelessWidget {
  final Widget widget;
  final String text;
  final ThemeData theme;

  LegendRow({this.widget, this.text, this.theme});

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
          style: theme.textTheme.bodyText1,
        ),
      ],
    );
  }
}
