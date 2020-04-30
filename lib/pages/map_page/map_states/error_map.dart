import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong/latlong.dart';

import 'package:flutter_shuttletracker/blocs/theme/theme_bloc.dart';
import 'package:flutter_shuttletracker/pages/map_page/map_widgets/attribution.dart';
import 'package:flutter_shuttletracker/pages/map_page/map_widgets//mapkey.dart';

class ErrorMap extends StatefulWidget {
  final String message;

  static const darkLink =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png';
  static const lightLink = 'http://tile.stamen.com/toner-lite/{z}/{x}/{y}.png';

  ErrorMap({this.message});

  @override
  _ErrorMapState createState() => _ErrorMapState();
}

class _ErrorMapState extends State<ErrorMap> {
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
                  options: MapOptions(
                    center: LatLng(42.731, -73.6767),
                    zoom: 14,
                    maxZoom: 16, // max you can zoom in
                    minZoom: 14, // min you can zoom out
                  ),
                  layers: [
                    TileLayerOptions(
                      backgroundColor: theme.bottomAppBarColor,
                      urlTemplate:
                          isDarkMode ? ErrorMap.darkLink : ErrorMap.lightLink,
                      subdomains: ['a', 'b', 'c'],
                      tileProvider: CachedNetworkTileProvider(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Attribution(),
          Mapkey(
            mapkey: {},
          ),
        ]);
      },
    );
  }
}
