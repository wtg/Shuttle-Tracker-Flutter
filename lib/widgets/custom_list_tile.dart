import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../blocs/on_tap_bloc/on_tap_bloc.dart';
import '../data/models/shuttle_route.dart';
import '../data/models/shuttle_stop.dart';
import '../pages/routes_page/detail_page.dart';

/// Class: CustomListTile Widget
/// Function: Widget that functions similar to a ListTile with functionality
///           specific to Shuttle widgets and the OnTapBloc
class CustomListTile extends StatelessWidget {
  final ShuttleRoute route;
  final List<ShuttleStop> stops;
  final ThemeData theme;
  final OnTapBloc bloc = OnTapBloc();

  /// Constructor of the CustomListTile Widget
  CustomListTile({this.route, this.stops, this.theme});

  bool get isEnabled => route.enabled;
  bool get isActive => route.active;

  /// Returns a mapping of ShuttleStops with their id number
  Map<int, ShuttleStop> _getRouteStops() {
    var stopIds = route.stopIds;
    var routeStops = <int, ShuttleStop>{};

    for (var stopId in stopIds) {
      routeStops[stopId] = null;
    }

    for (var shuttleStop in stops) {
      if (stopIds.contains(shuttleStop.id)) {
        routeStops[shuttleStop.id] = shuttleStop;
      }
    }

    return routeStops;
  }

  /// Standard build function for the CustomListTile widget
  @override
  Widget build(BuildContext context) {
    var polyline = <Polyline>[route.getPolyline];

//    var image = ShuttleImage(svgColor: route.color);
    var color = route.color;

    var circle = ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.modulate),
      child: Image.asset(
        'assets/img/stop_thin.png',
        width: 12,
        height: 12,
      ),
    );

    return BlocProvider(
      create: (_) => bloc,
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            circle,
            SizedBox(
              width: 15,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                route.name,
                style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            //Stack(
            //  alignment: AlignmentDirectional.center,
            //  children: <Widget>[
            //    Container(
            //      height: 20,
            //      width: 20,
            //      decoration: ShapeDecoration(
            //        color: Colors.white,
            //        shape: CircleBorder(),
            //      ),
            //    ),
            //    _getIcon(),
            //  ],
            //),
            Icon(
              Platform.isIOS
                  ? CupertinoIcons.right_chevron
                  : Icons.keyboard_arrow_right,
              color: theme.primaryColor,
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) {
                return DetailPage(
                  title: route.name,
                  polyline: polyline,
                  routeColor: color,
                  routeStops: _getRouteStops(),
                  bloc: bloc,
                );
              },
            ),
          );
        },
        /**                                                  Adds to Favorites
        onLongPress: () {
          route.favorite
              ? route.favorite = false
              : route.favorite = true;
          log("Set $name favorite route not $fav.");
          setState(() {});
          final favorited = route.favorite;
          FavoriteNotification(favorites: favorited)..dispatch(context);
        }, **/
      ),
    );
  }
}

/// Notification when a route is marked as a Favorite Route (not used for now)
class FavoriteNotification extends Notification {
  final bool favorites;

  const FavoriteNotification({this.favorites});
}
