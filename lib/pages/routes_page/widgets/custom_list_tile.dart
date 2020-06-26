import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../blocs/detail_map_on_tap/detail_map_on_tap_bloc.dart';
import '../../../models/shuttle_route.dart';
import '../../../models/shuttle_stop.dart';
import '../detail_page.dart';

class CustomListTile extends StatefulWidget {
  final ShuttleRoute route;
  final List<ShuttleStop> stops;
  final ThemeData theme;

  CustomListTile({this.route, this.stops, this.theme});

  bool get isEnabled => route.enabled;
  bool get isActive => route.active;

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  DetailMapOnTapBloc bloc = DetailMapOnTapBloc();

  Icon _getIcon() {
    var icon = widget.isEnabled && widget.isActive
        ? Icon(
            Icons.check_circle,
            color: Colors.green,
          )
        : widget.isEnabled && !widget.isActive
            ? Icon(
                Icons.error,
                color: Colors.yellow[700],
              )
            : Icon(
                Icons.error,
                color: Colors.red,
              );
    return icon;
  }

  Map<int, ShuttleStop> _getRouteStops() {
    var stopIds = widget.route.stopIds;
    var routeStops = <int, ShuttleStop>{};

    for (var stopId in stopIds) {
      routeStops[stopId] = null;
    }

    for (var shuttleStop in widget.stops) {
      if (stopIds.contains(shuttleStop.id)) {
        routeStops[shuttleStop.id] = shuttleStop;
      }
    }

    return routeStops;
  }

  @override
  Widget build(BuildContext context) {
    var polyline = <Polyline>[widget.route.getPolyline];

//    var image = ShuttleImage(svgColor: widget.route.color);
    var color = widget.route.color;
    var fav = widget.route.favorite;
    var name = widget.route.name;

    var circle = ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.modulate),
      child: Image.asset(
        'assets/img/stop_thin.png',
        width: 25,
        height: 25,
      ),
    );

    return BlocProvider(
      create: (_) => bloc,
      child: ListTile(
        leading: circle,
        title: Align(
          alignment: Alignment(-1.2, 0),
          child: Text(
            widget.route.name,
            style: TextStyle(
              color: widget.theme.hoverColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  height: 20,
                  width: 20,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: CircleBorder(),
                  ),
                ),
                _getIcon(),
              ],
            ),
            Icon(
              Platform.isIOS
                  ? CupertinoIcons.right_chevron
                  : Icons.keyboard_arrow_right,
              color: widget.theme.hoverColor,
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) {
                return DetailPage(
                  title: widget.route.name,
                  polyline: polyline,
                  routeColor: color,
                  routeStops: _getRouteStops(),
                  bloc: bloc,
                );
              },
            ),
          );
        },
        onLongPress: () {
          widget.route.favorite ? widget.route.favorite = false :
          widget.route.favorite = true;
          setState(() {});
          log("Set $name favorite route $fav.");
          final favorited = widget.route.favorite;
          FavoriteNotification(favorites: favorited)..dispatch(context);
        },
      ),
    );
  }
}

class FavoriteNotification extends Notification {
  final bool favorites;

  const FavoriteNotification({this.favorites});
}