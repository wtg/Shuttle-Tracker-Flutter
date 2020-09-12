import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../../blocs/theme/theme_bloc.dart';
import '../../global_widgets/loading_state.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const darkLink =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}@2x.png';
  static const lightLink =
      'http://tile.stamen.com/toner-lite/{z}/{x}/{y}@2x.png';
  int i = 0;

  Connectivity connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    var lat = 42.729;
    var long = -73.6758;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(
          'assets/img/logo.png',
          height: 40,
          width: 40,
        ),
      ),
      body: StreamBuilder(
        stream: connectivity.onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.data != ConnectivityResult.none) {
            return Center(
              child: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, theme) {
                  var isDarkMode = theme.getThemeState;
                  try {
                    return Stack(children: <Widget>[
                      Column(
                        children: [
                          /// Map
                          Flexible(
                            child: FlutterMap(
                              //mapController: _mapController,
                              options: MapOptions(
                                nePanBoundary: LatLng(42.78, -73.63),
                                swPanBoundary: LatLng(42.68, -73.71),
                                center: LatLng(lat, long),
                                zoom: 14,
                                maxZoom: 16, // max you can zoom in
                                minZoom: 13, // min you can zoom out
                              ),
                              layers: [
                                TileLayerOptions(
                                  backgroundColor:
                                      theme.getTheme.bottomAppBarColor,
                                  urlTemplate:
                                      isDarkMode ? darkLink : lightLink,
                                  subdomains: ['a', 'b', 'c'],
                                  tileProvider: CachedNetworkTileProvider(),
                                ),
                                // PolylineLayerOptions(polylines: routes),
                                // MarkerLayerOptions(markers: stops),
                                // MarkerLayerOptions(markers: location),
                                // MarkerLayerOptions(markers: updates),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Attribution(
                      //   theme: theme.getTheme,
                      // ),
                      // Legend(
                      //   legend: _legend,
                      // ),
                    ]);
                  } catch (e) {
                    print(e);
                    return LoadingState();
                  }
                },
              ),
            );
          }
          return LoadingState();
        },
      ),

      // body: Center(
      //   child:
      //       BlocBuilder<ShuttleBloc, ShuttleState>(builder: (context, state) {
      //     if (state is ShuttleInitial) {
      //       shuttleBloc.add(ShuttleEvent.getMapPageData);
      //       print('state is initial');
      //       return InitialMap();
      //     } else if (state is ShuttleError) {
      //       shuttleBloc.add(ShuttleEvent.getMapPageData);
      //       print('state has error\n\n');
      //       return ErrorMap(
      //         message: state.message,
      //       );
      //     } else if (state is ShuttleLoaded) {
      //       print('state is loaded');
      //       i++;
      //       print('API poll $i\n\n');
      //       shuttleBloc.add(ShuttleEvent.getMapPageData);

      //       return LoadedMap(
      //         routes: state.routes,
      //         location: state.location,
      //         stops: state.stops,
      //         updates: state.updates,
      //       );
      //     }
      //     print('state is loading');
      //     return LoadingState();
      //   }),
      // ),
    );
  }
}
