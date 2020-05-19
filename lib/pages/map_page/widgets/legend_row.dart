import 'package:flutter/material.dart';

class LegendRow extends StatelessWidget {
  final Widget widget;
  final String text;

  LegendRow({this.widget, this.text});

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
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
