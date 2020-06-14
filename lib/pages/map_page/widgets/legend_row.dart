import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/theme/theme_bloc.dart';

class LegendRow extends StatelessWidget {
  final Widget widget;
  final String text;

  LegendRow({this.widget, this.text});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
      return Row(
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            child: widget,
          ),
          Text(
            text,
            style: theme.getTheme.textTheme.bodyText1,
          ),
        ],
      );
    });
  }
}
