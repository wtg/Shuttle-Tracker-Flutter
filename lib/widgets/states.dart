import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong/latlong.dart';

import '../models/ShuttleImage.dart';

/// Function to create the initial state the user will see
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

/// Function to create the loading state that the user will see
Widget buildLoadingState() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

/// Function to create the loaded state that the user will see
Widget buildLoadedState(
    List<Polyline> routes,
    List<Marker> location,
    List<Marker> stops,
    List<Marker> updates,
    Map<String, ShuttleImage> mapkey,
    Brightness brightness) {
  var isDarkMode = false;
  const darkLink =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png';
  const lightLink = 'http://tile.stamen.com/toner-lite/{z}/{x}/{y}.png';

  if (brightness == Brightness.dark) {
    isDarkMode = true;
  }

  List<Widget> mapkeyRows = [
    Row(
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          child: Image.asset('assets/img/user.png'),
        ),
        Text(
          ' You',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
      ],
    ),
  ];
  mapkey.forEach((key, value) {
    mapkeyRows.add(
      Row(
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            child: value.getSVG,
          ),
          Text(
            " $key",
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  });
  mapkeyRows.add(
    Row(
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          child: Image.asset('assets/img/circle.png'),
        ),
        Text(
          ' Shuttle Stop',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
      ],
    ),
  );

  print("Number of routes on map: ${routes.length}");
  print("Number of stops on map: ${stops.length}");
  print("Number of shuttles on map: ${updates.length}");
  print("Number of rows in mapkey: ${mapkeyRows.length}\n\n");

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
                backgroundColor: isDarkMode ? Colors.black : Colors.white,
                urlTemplate: isDarkMode ? darkLink : lightLink,
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
    Align(
      alignment: Alignment.bottomRight,
      child: Opacity(
        opacity: 0.75,
        child: Container(
            color: isDarkMode ? Colors.grey[900] : Colors.white,
            child: Text(
              'Map tiles: Stamen Design (CC BY 3.0) Data: OpenStreetMap (ODbL)',
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            )),
      ),
    ),
    Positioned(
      height: mapkeyRows.length * 18.0,
      width: 150,
      bottom: 30,
      left: 10,
      child: Opacity(
        opacity: 0.95,
        child: Container(
          decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(color: Colors.black, offset: Offset(0.0, 1.0))
              ]),
          child: ListView(
            children: mapkeyRows,
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    )
  ]);
}

/// Function to create the error state that the user will see
Widget buildErrorState(String message, Brightness brightness) {
  var isDarkMode = false;
  if (brightness == Brightness.dark) {
    isDarkMode = true;
  }

  return Column(
    children: <Widget>[
      Center(
        child: Text(
          message,
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
      ),
    ],
  );
}
