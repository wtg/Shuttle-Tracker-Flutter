import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shuttletracker/bloc/shuttle_bloc.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_shuttletracker/data/ShuttleRepository.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  initState() {
    print('INIT STATE');
    super.initState();
    final shuttleBloc = BlocProvider.of<ShuttleBloc>(context);
    shuttleBloc.add(GetShuttleMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            BlocBuilder<ShuttleBloc, ShuttleState>(builder: (context, state) {
          if (state is ShuttleInitial) {
            print('i');
            return buildInitialMap();
          } else if (state is ShuttleLoaded) {
            print('state');
            return buildShuttleMap(
                state.routes, state.location, state.stops, state.updates);
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

Widget buildShuttleMap(_routes, _location, _stops, _updates) {
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
            PolylineLayerOptions(polylines: _routes),
            MarkerLayerOptions(markers: _location),
            MarkerLayerOptions(markers: _stops),
            MarkerLayerOptions(markers: _updates),
          ],
        ),
      ),
    ],
  );
}
