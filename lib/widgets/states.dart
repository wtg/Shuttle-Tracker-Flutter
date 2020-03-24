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
  return Stack(children: <Widget>[
    Column(
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
                tileProvider: CachedNetworkTileProvider(),
              ),
              PolylineLayerOptions(polylines: routes),
              MarkerLayerOptions(markers: location),
              MarkerLayerOptions(markers: stops),
              MarkerLayerOptions(markers: updates),
            ],
          ),
        ),
      ],
    ),
    Positioned(
      height: 13,
      width: 400,
      bottom: 10,
      left: 10,
      child: Opacity(
        opacity: 0.7,
        child: Container(
          color: Colors.white,
          child: Align(
            child: Text(
              'Map tiles: Stamen Design (CC BY 3.0) Data: OpenStreetMap (ODbL)',
              style: TextStyle(fontSize: 12),
            ),
            alignment: Alignment.bottomCenter,
          ),
        ),
      ),
    ),
    Positioned(
      height: 100,
      width: 100,
      bottom: 50,
      left: 10,
      child: Opacity(
        opacity: 0.95,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            child: ListView(
              children: <Widget>[
                Text('LINE TEST 1'),
                Text('LINE TEST 2'),
                Text('LINE TEST 3'),
                Text('LINE TEST 4'),
              ],
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ),
      ),
    )
  ]);
}

Widget buildErrorState(String message) {
  return Center(
    child: Text(message),
  );
}
