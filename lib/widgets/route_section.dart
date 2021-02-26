import 'package:flutter/material.dart';

/// Class: RoutesSection
/// Function: Returns a widget that holds the heading of the Routes Section
class RoutesSection extends StatelessWidget {
  final ThemeData theme;
  final List<Widget> routes;
  final String sectionHeader;

  /// Constructor for the RoutesSection widget
  RoutesSection({this.theme, this.routes, this.sectionHeader});

  /// Standard build function for the widget
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded: sectionHeader == "Active Routes",
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
          ),
        )
      ],
    );
  }
}
