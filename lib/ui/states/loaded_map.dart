import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong/latlong.dart';

import '../../models/shuttle_image.dart';
import '../widgets/dark_mode_text.dart';
import '../widgets/hyperlink.dart';
import '../widgets/mapkey_row.dart';

class LoadedMap extends StatefulWidget {
  final List<Polyline> routes;
  final List<Marker> location;
  final List<Marker> stops;
  final List<Marker> updates;
  final Map<String, ShuttleImage> mapkey;
  final bool isDarkMode;

  static const darkLink =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png';
  static const lightLink = 'http://tile.stamen.com/toner-lite/{z}/{x}/{y}.png';

  LoadedMap(
      {this.routes,
      this.location,
      this.stops,
      this.updates,
      this.mapkey,
      this.isDarkMode});

  @override
  _LoadedMapState createState() => _LoadedMapState();
}

class _LoadedMapState extends State<LoadedMap> {
  @override
  Widget build(BuildContext context) {
    List<Widget> mapkeyRows = [
      MapkeyRow(
          widget: Image.asset('assets/img/user.png'),
          text: ' You',
          isDarkMode: widget.isDarkMode),
    ];
    widget.mapkey.forEach((key, value) {
      mapkeyRows.add(MapkeyRow(
          widget: value.getSVG, text: " $key", isDarkMode: widget.isDarkMode));
    });
    mapkeyRows.add(MapkeyRow(
        widget: Image.asset('assets/img/circle.png'),
        text: ' Shuttle Stop',
        isDarkMode: widget.isDarkMode));

    List<Widget> attribution = [
      DarkModeText(text: 'Map tiles: ', isDarkMode: widget.isDarkMode),
      Hyperlink(url: 'https://stamen.com/', text: 'Stamen Design '),
      DarkModeText(text: '(', isDarkMode: widget.isDarkMode),
      Hyperlink(
          url: 'https://creativecommons.org/licenses/by/3.0/',
          text: 'CC BY 3.0'),
      DarkModeText(text: ') Data: ', isDarkMode: widget.isDarkMode),
      Hyperlink(url: 'https://www.openstreetmap.org/', text: 'OpenStreetMap '),
      DarkModeText(text: '(', isDarkMode: widget.isDarkMode),
      Hyperlink(url: 'https://www.openstreetmap.org/copyright', text: 'ODbL'),
      DarkModeText(text: ')', isDarkMode: widget.isDarkMode),
    ];

    print("Number of routes on map: ${widget.routes.length}");
    print("Number of stops on map: ${widget.stops.length}");
    print("Number of shuttles on map: ${widget.updates.length}");
    print("Number of rows in mapkey: ${mapkeyRows.length}\n\n");
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
                PolylineLayerOptions(polylines: widget.routes),
                MarkerLayerOptions(markers: widget.location),
                MarkerLayerOptions(markers: widget.stops),
                MarkerLayerOptions(markers: widget.updates),
              ],
            ),
          ),
        ],
      ),

      /// Attribution
      Align(
        alignment: Alignment.bottomRight,
        child: Opacity(
          opacity: 0.90,
          child: Container(
              color: widget.isDarkMode ? Colors.grey[900] : Colors.white,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: attribution)),
        ),
      ),

      /// Mapkey
      Positioned(
        bottom: 40,
        left: 10,
        child: Opacity(
          opacity: 0.90,
          child: Container(
            decoration: BoxDecoration(
                color: widget.isDarkMode ? Colors.grey[900] : Colors.white,
                border: Border.all(
                  width: 5,
                  color: widget.isDarkMode
                      ? Colors.black.withOpacity(0.1)
                      : Colors.white.withOpacity(0.1),
                ),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: widget.isDarkMode ? Colors.white : Colors.black,
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
}
