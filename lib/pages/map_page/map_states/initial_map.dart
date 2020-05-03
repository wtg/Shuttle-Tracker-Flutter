import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong/latlong.dart';

class InitialMap extends StatefulWidget {
  @override
  _InitialMapState createState() => _InitialMapState();
}

class _InitialMapState extends State<InitialMap> {
  @override
  Widget build(BuildContext context) {
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
                urlTemplate:
                    'http://tile.stamen.com/toner-lite/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
                tileProvider: CachedNetworkTileProvider(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
