import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong/latlong.dart';

import '../../../blocs/theme/theme_bloc.dart';
import '../../../models/shuttle_image.dart';
import '../../../models/shuttle_route.dart';
import '../../../models/shuttle_stop.dart';
import '../../../models/shuttle_vehicle.dart';
import '../map_widgets/attribution.dart';
import '../map_widgets/mapkey.dart';

class LoadedMap extends StatefulWidget {
  final List<dynamic> routes;
  final List<dynamic> stops;
  final List<dynamic> updates;
  final LatLng location;

  /// Map of with the route number as key and color of that route as the value
  final Map<int, Color> _colors = {};

  /// Map of with name of route as key and ShuttleImage as the value
  final Map<String, ShuttleImage> _mapkey = {};

  /// List of all ids
  final List<int> _ids = [];

  static const darkLink =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png';
  static const lightLink = 'http://tile.stamen.com/toner-lite/{z}/{x}/{y}.png';

  LoadedMap({this.routes, this.location, this.stops, this.updates});

  @override
  _LoadedMapState createState() => _LoadedMapState();
}

class _LoadedMapState extends State<LoadedMap> with TickerProviderStateMixin {
  MapController mapController = MapController();

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

  List<Polyline> _createRoutes(List<dynamic> routesJSON, List<int> _ids,
      Map<String, ShuttleImage> _mapkey, Map<int, Color> _colors) {
    var polylines = <Polyline>[];

    for (var routeJSON in routesJSON) {
      var route = ShuttleRoute.fromJson(routeJSON);
      if (route.active && route.enabled) {
        _mapkey[route.name] = ShuttleImage(svgColor: route.color);
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

  List<Marker> _createStops(List<dynamic> stopsJSON) {
    var markers = <Marker>[];

    for (var stopJSON in stopsJSON) {
      var stop = ShuttleStop.fromJson(stopJSON);
      if (widget._ids.contains(stop.id)) {
        markers.add(stop.getMarker(animatedMapMove));
      }
    }
    //print("Number of stops on map: ${markers.length}");
    return markers;
  }

  List<Marker> _createUpdates(
      List<dynamic> updatesJSON, Map<int, Color> colors) {
    var markers = <Marker>[];

    for (var updateJSON in updatesJSON) {
      var update = ShuttleVehicle.fromJson(updateJSON);
      if (colors[update.routeId] != null) {
        update.setColor = colors[update.routeId];
      } else {
        update.setColor = Colors.white;
      }

      markers.add(update.getMarker);
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeData>(
      builder: (context, theme) {
        var isDarkMode = theme.bottomAppBarColor == Colors.black;
        return Stack(children: <Widget>[
          Column(
            children: [
              /// Map
              Flexible(
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    nePanBoundary: LatLng(42.78, -73.63),
                    swPanBoundary: LatLng(42.68, -73.71),
                    center: LatLng(42.731, -73.6767),
                    zoom: 14,
                    maxZoom: 16, // max you can zoom in
                    minZoom: 13, // min you can zoom out
                  ),
                  layers: [
                    TileLayerOptions(
                      backgroundColor: theme.bottomAppBarColor,
                      urlTemplate:
                          isDarkMode ? LoadedMap.darkLink : LoadedMap.lightLink,
                      subdomains: ['a', 'b', 'c'],
                      tileProvider: CachedNetworkTileProvider(),
                    ),
                    PolylineLayerOptions(
                        polylines: _createRoutes(widget.routes, widget._ids,
                            widget._mapkey, widget._colors)),
                    MarkerLayerOptions(
                        markers:
                            _createUpdates(widget.updates, widget._colors)),
                    MarkerLayerOptions(markers: _createStops(widget.stops)),
                    MarkerLayerOptions(
                        markers: _createLocation(widget.location)),
                  ],
                ),
              ),
            ],
          ),
          Attribution(),
          Mapkey(
            mapkey: widget._mapkey,
          ),
        ]);
      },
    );
  }
}
