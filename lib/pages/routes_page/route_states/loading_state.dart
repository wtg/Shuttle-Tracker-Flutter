import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingState extends StatefulWidget {
  final ThemeData theme;
  LoadingState({this.theme});
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<LoadingState> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.theme.appBarTheme.color,
        child: Center(child: CircularProgressIndicator()));
  }
}
