import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong/latlong.dart';

import '../../models/shuttle_image.dart';
import '../../models/shuttle_route.dart';
import '../../models/shuttle_stop.dart';
import '../../models/shuttle_vehicle.dart';
import '../widgets/attribution.dart';
import '../widgets/mapkey.dart';

class LoadedMap extends StatefulWidget {
  final List<dynamic> routes;
  final List<dynamic> stops;
  final List<dynamic> updates;
  final LatLng location;
  final bool isDarkMode;

  /// Map of with the route number as key and color of that route as the value
  final Map<int, Color> _colors = {};

  /// Map of with name of route as key and ShuttleImage as the value
  final Map<String, ShuttleImage> _mapkey = {};

  /// List of all ids
  final List<int> _ids = [];

  static const darkLink =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png';
  static const lightLink = 'http://tile.stamen.com/toner-lite/{z}/{x}/{y}.png';

  LoadedMap(
      {this.routes, this.location, this.stops, this.updates, this.isDarkMode});

  @override
  _LoadedMapState createState() => _LoadedMapState();
}

class _LoadedMapState extends State<LoadedMap> {
  MapController mapController = MapController();

  List<Polyline> _createRoutes(List<dynamic> routesJSON, List<int> _ids,
      Map<String, ShuttleImage> _mapkey, Map<int, Color> _colors) {
    var polylines = <Polyline>[];

    for (var routeJSON in routesJSON) {
      var route = ShuttleRoute.fromJson(routeJSON);
      if (route.active && route.enabled) {
        _mapkey[route.name] = ShuttleImage(svgColor: route.color);
        _ids.addAll(route.stopIds);
        polylines.add(Polyline(
          points: route.points,
          strokeWidth: route.width,
          color: route.color,
        ));
        for (var schedule in route.schedules) {
          _colors[schedule.routeId] = route.color;
        }
      }
    }
    print("Number of routes on map: ${polylines.length}");
    return polylines;
  }

  List<Marker> _createStops(List<dynamic> stopsJSON) {
    var markers = <Marker>[];

    for (var stopJSON in stopsJSON) {
      var stop = ShuttleStop.fromJson(stopJSON);
      if (widget._ids.contains(stop.id)) {
        markers.add(Marker(
            point: stop.getLatLng,
            width: 12.0,
            height: 12.0,
            builder: (ctx) => Container(
                child: GestureDetector(
                    onTap: () {
                      mapController.onReady.then((result) {
                        mapController.move(stop.getLatLng, 14);
                      });
                      print('Stop ${stop.name} clicked on');
                    },
                    child: Image.asset('assets/img/circle.png')))));
      }
    }
    print("Number of stops on map: ${markers.length}");
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

      markers.add(Marker(
          point: update.getLatLng,
          width: 30.0,
          height: 30.0,
          builder: (ctx) => RotationTransition(
              turns: AlwaysStoppedAnimation((update.heading - 45) / 360),
              child: update.image.getSVG)));
    }
    print("Number of shuttles on map: ${markers.length}");
    return markers;
  }

  List<Marker> _createLocation(LatLng coordinates) {
    var location = <Marker>[
      Marker(
          point: coordinates,
          width: 10.0,
          height: 10.0,
          builder: (ctx) => Image.asset('assets/img/user.png'))
    ];

    return location;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Column(
        children: [
          /// Map
          Flexible(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(42.731, -73.6767),
                zoom: 14,
                maxZoom: 16, // max you can zoom in
                minZoom: 14, // min you can zoom out
              ),
              layers: [
                TileLayerOptions(
                  backgroundColor:
                      widget.isDarkMode ? Colors.black : Colors.white,
                  urlTemplate: widget.isDarkMode
                      ? LoadedMap.darkLink
                      : LoadedMap.lightLink,
                  subdomains: ['a', 'b', 'c'],
                  tileProvider: CachedNetworkTileProvider(),
                ),
                PolylineLayerOptions(
                    polylines: _createRoutes(widget.routes, widget._ids,
                        widget._mapkey, widget._colors)),
                MarkerLayerOptions(markers: _createStops(widget.stops)),
                MarkerLayerOptions(
                    markers: _createUpdates(widget.updates, widget._colors)),
                MarkerLayerOptions(markers: _createLocation(widget.location)),
              ],
            ),
          ),
        ],
      ),
      Attribution(isDarkMode: widget.isDarkMode),
      Mapkey(
        isDarkMode: widget.isDarkMode,
        mapkey: widget._mapkey,
      ),
    ]);
  }
}
