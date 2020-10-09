import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../data/models/shuttle_route.dart';
import '../../../data/models/shuttle_stop.dart';
import '../widgets/custom_list_tile.dart';
import '../widgets/route_section.dart';

class LoadedRoutes extends StatefulWidget {
  final List<ShuttleRoute> routes;
  final List<ShuttleStop> stops;
  final ThemeData theme;

  LoadedRoutes({this.routes, this.stops, this.theme});
  @override
  _LoadedRoutes createState() => _LoadedRoutes();
}

class _LoadedRoutes extends State<LoadedRoutes> {

  List<Widget> _getActiveRoutes() {
    var tileList = <Widget>[];
    for (var route in widget.routes) {
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

  List<Widget> _getInactiveRoutes() {
    var tileList = <CustomListTile>[];
    for (var route in widget.routes) {
      var tile = CustomListTile(
          route: route, stops: widget.stops, theme: widget.theme);
      if (tile.isEnabled && !tile.isActive && !route.favorite) {
        tileList.add(tile);
      }
    }
    tileList.sort((a, b) => a.route.name.length.compareTo(b.route.name.length));
    return tileList;
  }

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
                routes: _getActiveRoutes(),
                sectionHeader: 'Active Routes',
              ),
              RoutesSection(
                theme: widget.theme,
                routes: _getInactiveRoutes(),
                sectionHeader: 'Inactive Routes',
              ),
            ],
          )),
    );
  }
}
