import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/theme/theme_bloc.dart';

class MapkeyRow extends StatelessWidget {
  final Widget widget;
  final String text;

  MapkeyRow({this.widget, this.text});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeData>(builder: (context, theme) {
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
    });
  }
}
