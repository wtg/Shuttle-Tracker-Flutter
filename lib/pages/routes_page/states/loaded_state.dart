import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../models/shuttle_route.dart';
import '../../../models/shuttle_stop.dart';
import '../widgets/custom_list_tile.dart';
import '../widgets/favorite_section.dart';
import '../widgets/route_section.dart';


class LoadedState extends StatefulWidget {
  final List<ShuttleRoute> routes;
  final List<ShuttleStop> stops;
  final ThemeData theme;

  LoadedState({this.routes, this.stops, this.theme});
  @override
  _LoadedState createState() => _LoadedState();
}

class _LoadedState extends State<LoadedState> {
  List<Widget> _getFavoriteRoutes() {
    var tileList = <CustomListTile>[];
    for (var route in widget.routes) {
      var tile = CustomListTile(
        route: route,
        stops: widget.stops,
        theme: widget.theme,
      );
      if (tile.isEnabled && tile.isFavorite) {
        tileList.add(tile);
      }
    }
    tileList.sort((a, b) => a.route.name.compareTo(b.route.name));
    return tileList;
  }

  List<Widget> _getActiveRoutes() {
    var tileList = <CustomListTile>[];
    for (var route in widget.routes) {
      var tile = CustomListTile(
        route: route,
        stops: widget.stops,
        theme: widget.theme,
      );
      if (tile.isEnabled && tile.isActive) {
        tileList.add(tile);
      }
    }
    tileList.sort((a, b) => a.route.name.compareTo(b.route.name));
    return tileList;
  }

  List<Widget> _getScheduledRoutes() {
    var tileList = <CustomListTile>[];
    for (var route in widget.routes) {
      var tile = CustomListTile(
          route: route, stops: widget.stops, theme: widget.theme);
      if (tile.isEnabled && !tile.isActive) {
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
              FavoritesSection(
                theme: widget.theme,
                routes: _getFavoriteRoutes(),
                sectionHeader: 'Favorite Routes',
              ),
              RoutesSection(
                theme: widget.theme,
                routes: _getActiveRoutes(),
                sectionHeader: 'Active Routes',
              ),
              RoutesSection(
                theme: widget.theme,
                routes: _getScheduledRoutes(),
                sectionHeader: 'Scheduled Routes',
              ),
            ],
          )),
    );
  }
}
