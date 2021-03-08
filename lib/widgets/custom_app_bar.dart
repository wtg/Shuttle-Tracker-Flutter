import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String pageName;
  const CustomAppBar({this.pageName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        pageName,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.w600),
      ),
      backgroundColor: Theme.of(context).appBarTheme.color,
    );
  }
}
