import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../blocs/fusion_bloc/fusion_bloc.dart';
import '../blocs/map_bloc/map_bloc.dart';
import '../blocs/theme_bloc/theme_bloc.dart';
import '../widgets/attribution.dart';
import '../widgets/legend.dart';
import '../widgets/loading_state.dart';
import '../widgets/shuttle_svg.dart';

/// Class: MapPage Widget
/// Function: Creates an instance of the MapPage widget
class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

/// Class: _MapPageState
/// Function: Provides the internal state of the MapPage widget, contains
///           information read during the widget's lifetime
class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  final Connectivity connectivity = Connectivity();
  final MapController mapController = MapController();
  final Stream<Position> positionStream = Geolocator.getPositionStream();
  List<Marker> location = [];

  static const darkLink =
      'https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}@2x.png';
  static const lightLink =
      'http://tile.stamen.com/toner-lite/{z}/{x}/{y}@2x.png';

  /// Animation for moving along the map to a specified location and zoom
  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
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

  @override
  void dispose() {
    connectivity.onConnectivityChanged.listen((_) {}).cancel();
    super.dispose();
  }

  /// Standard build function for MapPage widget state
  @override
  Widget build(BuildContext context) {
    var lat = 42.729;
    var long = -73.6758;
    var mapBloc = context.watch<MapBloc>();
    var fusionBloc = context.watch<FusionBloc>();
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
                  var routes = <Polyline>[];
                  var darkRoutes = <Polyline>[];
                  var stops = <Marker>[];

                  var legend = <String, ShuttleSVG>{};
                  var darkLegend = <String, ShuttleSVG>{};

                  return BlocBuilder<MapBloc, MapState>(
                    builder: (context, mapState) {
                      //print('State is $state');
                      if (mapState is MapInitial) {
                        // Initial State of MapPage
                        mapBloc.add(GetMapData(
                          animatedMapMove: _animatedMapMove,
                          context: context,
                        ));
                      } else if (mapState is MapLoaded) {
                        // MapPage is loaded
                        routes = mapState.routes;
                        darkRoutes = mapState.darkRoutes;
                        stops = mapState.stops;
                        legend = mapState.legend;
                        darkLegend = mapState.darkLegend;
                        fusionBloc.setShuttleColors = mapState.routeColors;
                      } else if (mapState is MapError) {
                        // MapPage encountered
                        // error
                        mapBloc.add(GetMapData(
                          animatedMapMove: _animatedMapMove,
                          context: context,
                        ));
                      } else {}
                      return BlocBuilder<FusionBloc, FusionState>(
                        builder: (context, fusionState) {
                          var updates = <Marker>[];
                          if (fusionState is FusionInitial) {
                          } else if (fusionState is FusionVehicleLoaded) {
                            updates = fusionState.updates;

                            print('Num of shuttles on map: ${updates.length}');
                          } else if (fusionState is FusionETALoaded) {
                            updates = fusionState.updates;
                          }

                          return StreamBuilder<Position>(
                              stream: positionStream,
                              builder: (context, position) {
                                var data = position.data;
                                if (position.connectionState ==
                                    ConnectionState.active) {
                                  if (data.latitude != null &&
                                      data.longitude != null) {
                                    location = <Marker>[
                                      Marker(
                                          height: 12,
                                          width: 12,
                                          builder: (ctx) => Container(
                                                child: Image.asset(
                                                  'assets/img/user.png',
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                          point: LatLng(
                                              data.latitude, data.longitude))
                                    ];
                                  }
                                }

                                return Stack(children: <Widget>[
                                  Column(
                                    children: [
                                      /// Map
                                      Flexible(
                                        child: FlutterMap(
                                          // Map Widget
                                          mapController: mapController,
                                          options: MapOptions(
                                            interactiveFlags:
                                                InteractiveFlag.all &
                                                    ~InteractiveFlag.rotate,
                                            nePanBoundary:
                                                LatLng(42.78, -73.63),
                                            swPanBoundary:
                                                LatLng(42.68, -73.71),
                                            center: LatLng(lat, long),
                                            zoom: 14,
                                            maxZoom: 16, // max you can zoom in
                                            minZoom: 13, // min you can zoom out
                                          ),
                                          layers: [
                                            TileLayerOptions(
                                                backgroundColor: theme
                                                    .getTheme.bottomAppBarColor,
                                                urlTemplate: isDarkMode
                                                    ? darkLink
                                                    : lightLink,
                                                subdomains: ['a', 'b', 'c'],
                                                errorTileCallback:
                                                    (tile, dynamic) =>
                                                        {log('TILE ERROR!!')}),
                                            PolylineLayerOptions(
                                                polylines: isDarkMode
                                                    ? darkRoutes
                                                    : routes),
                                            MarkerLayerOptions(
                                                markers: location),
                                            MarkerLayerOptions(markers: stops),
                                            MarkerLayerOptions(
                                                markers: updates),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Attribution(),
                                  Legend(
                                    // Legend Widget
                                    legend: isDarkMode ? darkLegend : legend,
                                  ),
                                ]);
                              });
                        },
                      );
                    },
                  );
                },
              ),
            );
          }
          return LoadingScreen(); // MapPage has not Loaded yet
        },
      ),
    );
  }
}
