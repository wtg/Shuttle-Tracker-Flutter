import 'package:flutter/material.dart';

class RoutesSection extends StatelessWidget {
  final ThemeData theme;
  final List<Widget> routes;
  final String sectionHeader;
  RoutesSection({this.theme, this.routes, this.sectionHeader});

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ExpansionTile(
              initiallyExpanded:
                  sectionHeader == "Active Routes" ? true : false,
              title: Text(
                sectionHeader,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
              children: routes,
            ),
          ),
        )
      ],
    );
  }
}
