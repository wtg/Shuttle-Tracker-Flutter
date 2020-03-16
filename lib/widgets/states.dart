import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong/latlong.dart';

Widget buildInitialState() {
  return Column(
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
              urlTemplate: 'http://tile.stamen.com/toner-lite/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              // For example purposes. It is recommended to use
              // TileProvider with a caching and retry strategy, like
              // NetworkTileProvider or CachedNetworkTileProvider
              tileProvider: CachedNetworkTileProvider(),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildLoadingState() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildLoadedState(routes, location, stops, updates) {
  return Column(
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
              urlTemplate: 'http://tile.stamen.com/toner-lite/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              // For example purposes. It is recommended to use
              // TileProvider with a caching and retry strategy, like
              // NetworkTileProvider or CachedNetworkTileProvider
              tileProvider: CachedNetworkTileProvider(),
            ),
            PolylineLayerOptions(polylines: routes),
            MarkerLayerOptions(markers: location),
            MarkerLayerOptions(markers: stops),
            MarkerLayerOptions(markers: updates),
            //MarkerLayerOptions(markers: [Marker(point: LatLng(42.72, -73.6767),width: 10,height: 10,builder: (context) => new Container(child: IconButton(icon: Icon(Icons.location_on),iconSize: 10,color: Colors.red, onPressed: (){print('hello');},)))])
          ],
        ),
      ),
    ],
  );
}

Widget buildErrorState(String message) {
  return Center(
    child: Text(message),
  );
}
