import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../../../blocs/on_tap_eta/on_tap_eta_bloc.dart';
import '../../../blocs/theme/theme_bloc.dart';
import '../../../global_widgets/shuttle_arrow.dart';
import '../../../models/shuttle_route.dart';
import '../../../models/shuttle_stop.dart';
import '../../../models/shuttle_update.dart';
import '../widgets/attribution.dart';
import '../widgets/legend.dart';

class LoadedMap extends StatefulWidget {
  final List<ShuttleRoute> routes;
  final List<ShuttleStop> stops;
  final List<ShuttleUpdate> updates;
  final LatLng location;

  static const darkLink =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}@2x.png';
  static const lightLink =
      'http://tile.stamen.com/toner-lite/{z}/{x}/{y}@2x.png';

  LoadedMap({this.routes, this.location, this.stops, this.updates});

  @override
  _LoadedMapState createState() => _LoadedMapState();
}

class _LoadedMapState extends State<LoadedMap> with TickerProviderStateMixin {
  final MapController _mapController = MapController();

  /// Map of with the route number as key and color of that route as the value
  final Map<int, Color> _colors = {};

  /// Map of with name of route as key and ShuttleImage as the value
  final Map<String, ShuttleArrow> _legend = {};

  /// List of all ids
  final List<int> _ids = [];

  void animatedMapMove(LatLng destLocation, double destZoom) {
    final _latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.move(
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

  List<Polyline> _createRoutes(List<ShuttleRoute> routes, List<int> _ids,
      Map<String, ShuttleArrow> _legend, Map<int, Color> _colors) {
    var polylines = <Polyline>[];

    for (var route in routes) {
      if (route.active && route.enabled) {
        _legend[route.name] = ShuttleArrow(svgColor: route.color);
        _ids.addAll(route.stopIds);
        polylines.add(route.getPolyline);
        for (var schedule in route.schedules) {
          _colors[schedule.routeId] = route.color;
        }
      }
    }
    //print("Number of routes on map: ${polylines.length}");
    return polylines;
  }

  List<Marker> _createStops(List<ShuttleStop> stops, BuildContext context,
      ThemeData theme, OnTapEtaBloc bloc) {
    var markers = <Marker>[];

    for (var stop in stops) {
      if (_ids.contains(stop.id)) {
        markers.add(stop.getEtaMarker(
          animatedMapMove: animatedMapMove,
          context: context,
          bloc: bloc,
        )); //bloc: bloc));                      //Ask Sam why this is commented
      }
    }
    //print("Number of stops on map: ${markers.length}");
    return markers;
  }

  List<Marker> _createUpdates(List<ShuttleUpdate> updates, BuildContext context,
      Map<int, Color> colors) {
    var markers = <Marker>[];

    for (var update in updates) {
      if (colors[update.routeId] != null) {
        update.setColor = colors[update.routeId];
      } else {
        update.setColor = Colors.white;
      }

      markers.add(update.getMarker(animatedMapMove, context));
    }
    //print("Number of shuttles on map: ${markers.length}");
    return markers;
  }

  List<Marker> _createLocation(LatLng coordinates) {
    var location = <Marker>[
      Marker(
          point: coordinates,
          width: 12.0,
          height: 12.0,
          builder: (ctx) => Image.asset('assets/img/user.png'))
    ];

    return location;
  }

  LatLng findAvgLatLong(List<ShuttleStop> shuttleStops) {
    var lat = 42.729;
    var long = -73.6758;
    var totalLen = shuttleStops.length;
    if (totalLen != 0) {
      lat = 0;
      long = 0;

      shuttleStops.forEach((value) {
        var temp = value.getLatLng;
        lat += temp.latitude;
        long += temp.longitude;
      });

      lat /= totalLen;
      long /= totalLen;
    }

    return LatLng(lat, long);
  }

  @override
  Widget build(BuildContext context) {
    var onTapBloc = context.bloc<OnTapEtaBloc>();
    return Scaffold(
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, theme) {
          var isDarkMode = theme.getThemeState;

          return BlocBuilder<OnTapEtaBloc, OnTapEtaState>(
            builder: (context, state) {
              var routes = _createRoutes(widget.routes, _ids, _legend, _colors);
              var updates = _createUpdates(widget.updates, context, _colors);
              var stops = _createStops(
                  widget.stops, context, theme.getTheme, onTapBloc);
              var location = _createLocation(widget.location);

              return Stack(children: <Widget>[
                Column(
                  children: [
                    /// Map
                    Flexible(
                      child: FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          nePanBoundary: LatLng(42.78, -73.63),
                          swPanBoundary: LatLng(42.68, -73.71),
                          center: findAvgLatLong(widget.stops),
                          zoom: 14,
                          maxZoom: 16, // max you can zoom in
                          minZoom: 13, // min you can zoom out
                        ),
                        layers: [
                          TileLayerOptions(
                            backgroundColor: theme.getTheme.bottomAppBarColor,
                            urlTemplate: isDarkMode
                                ? LoadedMap.darkLink
                                : LoadedMap.lightLink,
                            subdomains: ['a', 'b', 'c'],
                            tileProvider: CachedNetworkTileProvider(),
                          ),
                          PolylineLayerOptions(polylines: routes),
                          MarkerLayerOptions(markers: stops),
                          MarkerLayerOptions(markers: location),
                          MarkerLayerOptions(markers: updates),
                        ],
                      ),
                    ),
                  ],
                ),
                Attribution(
                  theme: theme.getTheme,
                ),
                Legend(
                  legend: _legend,
                ),
              ]);
            },
          );
        },
      ),
    );
  }
}
