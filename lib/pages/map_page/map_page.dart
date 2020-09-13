import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../../blocs/on_tap_eta/on_tap_eta_bloc.dart';
import '../../blocs/shuttle/shuttle_bloc.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../global_widgets/loading_state.dart';
import '../../models/shuttle_stop.dart';
import 'widgets/attribution.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  static const darkLink =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}@2x.png';
  static const lightLink =
      'http://tile.stamen.com/toner-lite/{z}/{x}/{y}@2x.png';
  int i = 0;

  Connectivity connectivity = Connectivity();

  final MapController _mapController = MapController();

  void animatedMapMove(LatLng destLocation, double destZoom) {
    final _latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  List<Marker> _createLocation(LatLng coordinates) {
    var location = <Marker>[
      Marker(
          point: coordinates,
          width: 12.0,
          height: 12.0,
          builder: (ctx) => Image.asset('assets/img/user.png'))
    ];

    return location;
  }

  LatLng findAvgLatLong(List<ShuttleStop> shuttleStops) {
    var lat = 42.729;
    var long = -73.6758;
    var totalLen = shuttleStops.length;
    if (totalLen != 0) {
      lat = 0;
      long = 0;

      shuttleStops.forEach((value) {
        var temp = value.getLatLng;
        lat += temp.latitude;
        long += temp.longitude;
      });

      lat /= totalLen;
      long /= totalLen;
    }

    return LatLng(lat, long);
  }

  @override
  Widget build(BuildContext context) {
    var initialLat = 42.729;
    var initialong = -73.6758;
    var center = LatLng(initialLat, initialong);
    var shuttleBloc = context.bloc<ShuttleBloc>();
    var onTapBloc = context.bloc<OnTapEtaBloc>();

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
                    return BlocBuilder<OnTapEtaBloc, OnTapEtaState>(
                        builder: (context, snapshot) {
                      return BlocBuilder<ShuttleBloc, ShuttleState>(
                          builder: (context, state) {
                        var routes = <Polyline>[];
                        var updates = <Marker>[];
                        var stops = <Marker>[];
                        var location = <Marker>[];
                        var event = GetMapPageData(
                            context: context,
                            animatedMapMove: animatedMapMove,
                            bloc: onTapBloc,
                            theme: theme.getTheme,
                          );

                        if (state is ShuttleInitial) {
                          shuttleBloc.add(event);
                          print('state is initial');
                        } else if (state is ShuttleError) {
                          shuttleBloc.add(event);
                          print('state has error\n\n');
                        } else if (state is ShuttleLoaded) {
                          print('state is loaded');
                          i++;
                          print('API poll $i\n\n');
                          shuttleBloc.add(event);

                          routes = state.routes;
                          updates = state.updates;
                          stops = state.stops;
                          location = _createLocation(state.location);
                          // center = findAvgLatLong(state.stops);
                        }
                        // print('state is loading');

                        return Stack(children: <Widget>[
                          Column(
                            children: [
                              /// Map
                              Flexible(
                                child: FlutterMap(
                                  mapController: _mapController,
                                  options: MapOptions(
                                    nePanBoundary: LatLng(42.78, -73.63),
                                    swPanBoundary: LatLng(42.68, -73.71),
                                    center: center,
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
                                    PolylineLayerOptions(polylines: routes),
                                    MarkerLayerOptions(markers: stops),
                                    MarkerLayerOptions(markers: location),
                                    MarkerLayerOptions(markers: updates),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Attribution(
                            theme: theme.getTheme,
                          ),
                          // Legend(
                          //   legend: _legend,
                          // ),
                        ]);
                      });
                    });
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
    );
  }
}
