import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/widgets.dart';

import 'package:latlong/latlong.dart';

import '../models/shuttle_image.dart';
import 'dark_mode_text.dart';
import 'hyperlink.dart';
import 'mapkey_row.dart';

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
    {List<Polyline> routes,
    List<Marker> location,
    List<Marker> stops,
    List<Marker> updates,
    Map<String, ShuttleImage> mapkey,
    bool isDarkMode}) {
  const darkLink =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png';
  const lightLink = 'http://tile.stamen.com/toner-lite/{z}/{x}/{y}.png';

  List<Widget> mapkeyRows = [
    MapkeyRow(
        widget: Image.asset('assets/img/user.png'),
        text: ' You',
        isDarkMode: isDarkMode),
  ];
  mapkey.forEach((key, value) {
    mapkeyRows.add(
        MapkeyRow(widget: value.getSVG, text: " $key", isDarkMode: isDarkMode));
  });
  mapkeyRows.add(MapkeyRow(
      widget: Image.asset('assets/img/circle.png'),
      text: ' Shuttle Stop',
      isDarkMode: isDarkMode));

  List<Widget> attribution = [
    IsDarkModeText(text: 'Map tiles: ', isDarkMode: isDarkMode),
    Hyperlink(url: 'https://stamen.com/', text: 'Stamen Design '),
    IsDarkModeText(text: '(', isDarkMode: isDarkMode),
    Hyperlink(
        url: 'https://creativecommons.org/licenses/by/3.0/', text: 'CC BY 3.0'),
    IsDarkModeText(text: ') Data: ', isDarkMode: isDarkMode),
    Hyperlink(url: 'https://www.openstreetmap.org/', text: 'OpenStreetMap '),
    IsDarkModeText(text: '(', isDarkMode: isDarkMode),
    Hyperlink(url: 'https://www.openstreetmap.org/copyright', text: 'ODbL'),
    IsDarkModeText(text: ')', isDarkMode: isDarkMode),
  ];

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
              center: LatLng(42.731, -73.6767),
              zoom: 14,
              maxZoom: 16, // max you can zoom in
              minZoom: 14, // min you can zoom out
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
        opacity: 0.90,
        child: Container(
            color: isDarkMode ? Colors.grey[900] : Colors.white,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: attribution)),
      ),
    ),
    Positioned(
      bottom: 40,
      left: 10,
      child: Opacity(
        opacity: 0.90,
        child: Container(
          decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              border: Border.all(width: 5, color: Colors.white),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: isDarkMode ? Colors.white : Colors.black,
                    offset: Offset(0.0, 0.5))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: mapkeyRows,
          ),
        ),
      ),
    ),
  ]);
}

/// Function to create the error state that the user will see
Widget buildErrorState({String message, bool isDarkMode}) {
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
