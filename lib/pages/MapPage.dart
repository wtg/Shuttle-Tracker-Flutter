import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shuttletracker/bloc/shuttle_bloc.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  /*
  @override
  initState() {
    print('INIT STATE');
    super.initState();
    final shuttleBloc = BlocProvider.of<ShuttleBloc>(context);
    shuttleBloc.add(GetShuttleMap());
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            BlocBuilder<ShuttleBloc, ShuttleState>(builder: (context, state) {
          if (state is ShuttleInitial) {
            print('state is initial');
            return buildInitialMap();
          } else if (state is ShuttleLoaded) {
            print('state is loaded');
            return buildLoadedMap(
                state.routes, state.location, state.stops, state.updates);
          } else {
            return buildInitialMap(); //TODO: MODFIY THIS LATER
          }
        }),
      ),
    );
  }
}

Widget buildInitialMap() {
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

Widget buildLoadedMap(routes, location, stops, updates) {
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
          ],
        ),
      ),
    ],
  );
}
