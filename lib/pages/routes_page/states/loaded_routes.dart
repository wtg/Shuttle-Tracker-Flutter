import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../data/models/shuttle_route.dart';
import '../../../data/models/shuttle_stop.dart';
import '../widgets/custom_list_tile.dart';
import '../widgets/route_section.dart';

/// Class: LoadedRoutes Widget
/// Function: Widget that represents the state of the content on the Routes Page
class LoadedRoutes extends StatefulWidget {
  final List<ShuttleRoute> routes;
  final List<ShuttleRoute> darkRoutes;
  final List<ShuttleStop> stops;
  final ThemeData theme;

  /// Constructor for the LoadedRoutes widget
  LoadedRoutes({this.routes, this.darkRoutes, this.stops, this.theme});

  @override
  _LoadedRoutes createState() => _LoadedRoutes();
}

/// Class: _LoadedRoutes Widget
/// Function: Returns the state of the LoadedRoutes widget
class _LoadedRoutes extends State<LoadedRoutes> {
  /// Returns a list of CustomListTiles for all Active Shuttle Routes
  List<Widget> _getActiveRoutes(ThemeData theme) {
    var tileList = <Widget>[];
    var currRoutes = (theme.brightness == Brightness.dark)
        ? widget.darkRoutes
        : widget.routes;
    for (var route in currRoutes) {
      var tile = CustomListTile(
        route: route,
        stops: widget.stops,
        theme: widget.theme,
      );
      if (tile.isEnabled && tile.isActive && !route.favorite) {
        tileList.add(tile);
      }
    }
    // tileList.sort((a, b) => a.route.name.compareTo(b.route.name));
    return tileList;
  }

  /// Returns a list of CustomListTiles for all Inactive Shuttle Routes
  List<Widget> _getInactiveRoutes(ThemeData theme) {
    var tileList = <CustomListTile>[];
    var currRoutes = (theme.brightness == Brightness.dark)
        ? widget.darkRoutes
        : widget.routes;
    for (var route in currRoutes) {
      var tile = CustomListTile(
          route: route, stops: widget.stops, theme: widget.theme);
      if (tile.isEnabled && !tile.isActive && !route.favorite) {
        tileList.add(tile);
      }
    }
    tileList.sort((a, b) => a.route.name.length.compareTo(b.route.name.length));
    return tileList;
  }

  /// Standard build function to construct the state
  @override
  Widget build(BuildContext context) {
    //notification listener used to remove scroll glow
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return null;
      },
      child: Container(
          color: widget.theme.backgroundColor,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              RoutesSection(
                theme: widget.theme,
                routes: _getActiveRoutes(widget.theme),
                sectionHeader: 'Active Routes',
              ),
              RoutesSection(
                theme: widget.theme,
                routes: _getInactiveRoutes(widget.theme),
                sectionHeader: 'Inactive Routes',
              ),
            ],
          )),
    );
  }
}
