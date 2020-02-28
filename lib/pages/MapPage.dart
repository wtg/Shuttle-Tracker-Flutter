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

  List<Polyline> _routes = List<Polyline>();
  List<Marker> _markers = List<Marker>();
  

  @override
  Widget build(BuildContext context) {
    fetchRoutes(http.Client()).then((value) {
      //setState(() {
      _routes.addAll(value);
     // });
    });
    
    fetchLocation().then((value) {
      _markers.addAll(value);
    });
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(42.73, -73.677),
                  zoom: 14.2,
                  maxZoom: 16,
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
                  MarkerLayerOptions(
                    markers: _markers
                  ),
                  PolylineLayerOptions(
                    polylines: _routes
                  )
                ],
              ),
            ),
          ], 
        ),
      ),
    );
  }
}