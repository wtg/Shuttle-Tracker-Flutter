import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/theme_bloc/theme_bloc.dart';

/// Class: RoutesSection
/// Function: Returns a widget that holds the heading of the Routes Section
class RoutesSection extends StatelessWidget {
  final List<Widget> routes;
  final String sectionHeader;

  /// Constructor for the RoutesSection widget
  RoutesSection({this.routes, this.sectionHeader});

  /// Standard build function for the widget
  @override
  Widget build(BuildContext context) {
    var themeBloc = context.watch<ThemeBloc>();
    var theme = themeBloc.state;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: theme.getThemeState ? 0 : 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded: sectionHeader == 'Active Routes',
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
