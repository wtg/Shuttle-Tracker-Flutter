import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_shuttletracker/fetch.dart';


class MapPage extends StatefulWidget {

  MapPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  
  var _routes = <Polyline>[];
  var _location = <Marker>[];
  var _updates = <Marker>[];
  var _stops = <Marker>[];

  @override
  initState() {
    print('INIT STATE');
    super.initState();

    fetchUpdates(http.Client()).then((value) {
      setState(() {});
      _updates.addAll(value);
    });

    fetchRoutes(http.Client()).then((value) {
      setState(() {});
      _routes.addAll(value);
    });

    fetchLocation().then((value) {
      _location.addAll(value);
    });

    
    fetchStops(http.Client()).then((value) {
      _stops.addAll(value);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(42.73, -73.6767),
                  zoom: 14,
                  maxZoom: 20,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'http://tile.stamen.com/toner-lite/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    // For example purposes. It is recommended to use
                    // TileProvider with a caching and retry strategy, like
                    // NetworkTileProvider or CachedNetworkTileProvider
                    tileProvider: CachedNetworkTileProvider(),
                  ),
                  PolylineLayerOptions(
                    polylines: _routes
                  ),
                  MarkerLayerOptions(
                    markers: _location
                  ),
                  MarkerLayerOptions(
                    markers: _stops
                  ),
                  MarkerLayerOptions(
                    markers: _updates
                  ),
                ],
              ),
            ),
          ], 
        ),
      ),
    );
  }
}