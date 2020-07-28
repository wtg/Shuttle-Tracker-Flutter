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
