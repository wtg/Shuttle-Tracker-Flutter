import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

import '../blocs/on_tap_bloc/on_tap_bloc.dart';
import '../blocs/theme_bloc/theme_bloc.dart';
import '../data/models/shuttle_stop.dart';
import '../widgets/panel.dart';

/// Class: DetailPage
/// Function: Widget that represents the specific detail page of a route from
///           the Routes Page
class DetailPage extends StatefulWidget {
  final String title;
  final List<Polyline> polyline;
  final Map<int, ShuttleStop> routeStops;
  final Color routeColor;
  final OnTapBloc bloc;

  /// Constructor of the DetailPage widget
  DetailPage(
      {this.title, this.polyline, this.routeStops, this.routeColor, this.bloc});

  @override
  _DetailPageState createState() => _DetailPageState();
}

/// Class: _DetailPageState
/// Function: Represents the state of the DetailPage widget
class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  MapController mapController = MapController();
  final _markers = <Marker>[];

  static const darkLink =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}@2x.png';
  static const lightLink =
      'http://tile.stamen.com/toner-lite/{z}/{x}/{y}@2x.png';

  /// Represents the animation for moving the map to a specific stop
  /// based on location and zoom
  void animatedMapMove(LatLng destLocation, double destZoom) {
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  /// Creates the stop markers based on a mapping of ShuttleStops
  void _createStops(Map<int, ShuttleStop> shuttleStops) {
    var index = 0;
    shuttleStops.forEach((key, value) {
      _markers.add(
        value.getMarker(
            animatedMapMove: animatedMapMove,
            bloc: widget.bloc,
            index: index,
            isRoutesPage: true,
            routeColor: widget.routeColor),
      );
      index++;
    });

//    return markers;
  }

  /// Returns the center point of the route from a mapping of ShuttleStops
  LatLng findAvgLatLong(Map<int, ShuttleStop> shuttleStops) {
    var lat = 42.729;
    var long = -73.6758;
    var totalLen = shuttleStops.length;
    if (totalLen != 0) {
      lat = 0;
      long = 0;

      shuttleStops.forEach((key, value) {
        var temp = value.getLatLng;
        lat += temp.latitude;
        long += temp.longitude;
      });

      lat /= totalLen;
      long /= totalLen;
    }

    return LatLng(lat, long);
  }

  /// Standard build function that creates the state of the DetailPage
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, theme) {
      var isDarkMode = theme.getTheme.bottomAppBarColor == Colors.black;

      var mapCenter = findAvgLatLong(widget.routeStops);
      return Scaffold(
        appBar: AppBar(
          leading: Container(
            color: theme.getTheme.appBarTheme.color,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: theme.getTheme.primaryColor,
              onPressed: () => Navigator.pop(context, false),
            ),
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              color: theme.getTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: theme.getTheme.appBarTheme.color,
        ),
        body: BlocBuilder<OnTapBloc, OnTapState>(
            bloc: widget.bloc,
            builder: (context, state) {
              _createStops(widget.routeStops);
              return Column(
                children: <Widget>[
                  Flexible(
                    child: FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        nePanBoundary: LatLng(42.78, -73.63),
                        swPanBoundary: LatLng(42.68, -73.71),
                        center: mapCenter,
                        zoom: 13.9,
                        maxZoom: 16, // max you can zoom in
                        minZoom: 13, // min you can zoom out
                      ),
                      layers: [
                        TileLayerOptions(
                          backgroundColor: theme.getTheme.bottomAppBarColor,
                          urlTemplate: isDarkMode ? darkLink : lightLink,
                          subdomains: ['a', 'b', 'c'],
                        ),
                        PolylineLayerOptions(polylines: widget.polyline),
                        MarkerLayerOptions(
                          markers: _markers,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: widget.routeColor,
                    thickness: 4,
                  ),
                  Flexible(
                    child: Panel(
                      routeColor: widget.routeColor,
                      routeStops: widget.routeStops,
                      animate: animatedMapMove,
                      bloc: widget.bloc,
                    ),
                  ),
                ],
              );
            }),
      );
    });
  }
}
