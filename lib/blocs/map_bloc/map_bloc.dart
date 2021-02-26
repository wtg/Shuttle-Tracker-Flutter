import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../../data/models/shuttle_route.dart';
import '../../data/models/shuttle_stop.dart';
import '../../data/models/shuttle_update.dart';
import '../../data/repository/shuttle_repository.dart';
import '../../widgets/shuttle_svg.dart';
import '../on_tap_bloc/on_tap_bloc.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final ShuttleRepository repository;
  bool isLoading = true;

  MapBloc({this.repository}) : super(MapInitial());

  MapRoutes _createRoutes({
    @required List<ShuttleRoute> routes,
  }) {
    var polylines = <Polyline>[];
    var darkPolylines = <Polyline>[];

    for (var route in routes) {
      if (route.active && route.enabled) {
        polylines.add(route.getPolyline);
        darkPolylines.add(route.getDarkPolyline);
      }
    }
    polylines.sort((a, b) => b.strokeWidth.compareTo(a.strokeWidth));
    darkPolylines.sort((a, b) => b.strokeWidth.compareTo(a.strokeWidth));

    return MapRoutes(polylines: polylines, darkPolylines: darkPolylines);
  }

  List<Marker> _createStops(
      {@required List<ShuttleStop> stops,
      @required BuildContext context,
      @required OnTapBloc bloc,
      @required List<int> ids,
      @required animatedMapMove}) {
    var markers = <Marker>[];

    for (var stop in stops) {
      if (ids.contains(stop.id)) {
        markers.add(stop.getMarker(
          animatedMapMove: animatedMapMove,
          context: context,
          bloc: bloc,
          isRoutesPage: false,
        ));
      }
    }
    //print("Number of stops on map: ${markers.length}");
    return markers;
  }

  List<Marker> _createUpdates(
      {@required List<ShuttleUpdate> updates,
      @required BuildContext context,
      @required Map<int, Color> colors,
      animatedMapMove}) {
    var markers = <Marker>[];

    for (var update in updates) {
      if (colors[update.routeId] != null) {
        update.setColor = colors[update.routeId];
      } else {
        update.setColor = Colors.white;
      }

      markers.add(update.getMarker(animatedMapMove, context));
    }
    //print("Number of shuttles on map: ${markers.length}");
    return markers;
  }

  LatLng _findAvgLatLong(List<ShuttleStop> shuttleStops) {
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
  Stream<MapState> mapEventToState(MapEvent event) async* {
    MapRoutes mapRoutes;
    var routes = <Polyline>[];
    var darkRoutes = <Polyline>[];
    var stops = <Marker>[];
    var updates = <Marker>[];
    var location = <Marker>[];
    LatLng center;

    var repoRoutes = await repository.getRoutes;
    var repoStops = await repository.getStops;
    var repoUpdates = await repository.getUpdates;
    var auxData = await repository.getAuxiliaryRouteData();

    // Probably a janky implementation since we create two instances of
    // everything. Instead of figuring out whether the theme changes
    // in the bloc, we choose the appropriate theme in the map page itself
    // based off of the bloc updates from the theme bloc
    // The same method is used for dark routes
    if (event is GetMapData) {
      mapRoutes = _createRoutes(
        routes: repoRoutes,
      );

      routes = mapRoutes.polylines;
      darkRoutes = mapRoutes.darkPolylines;

      stops = _createStops(
          stops: repoStops,
          context: event.context,
          bloc: event.bloc,
          ids: auxData.ids,
          animatedMapMove: event.animatedMapMove);

      updates = _createUpdates(
          updates: repoUpdates,
          context: event.context,
          colors: auxData.colors,
          animatedMapMove: event.animatedMapMove);

      center = _findAvgLatLong(repoStops);

      if (isLoading) {
        yield MapLoading();
        isLoading = false;
      } else {
        /// Poll every 3ish seconds
        // await Future.delayed(const Duration(seconds: 2));
      }

      if (repository.getIsConnected) {
        yield MapLoaded(
            routes: routes,
            darkRoutes: darkRoutes,
            stops: stops,
            updates: updates,
            location: location,
            center: center,
            legend: auxData.legend,
            darkLegend: auxData.darkLegend,
            routeColors: auxData.colors);
      } else {
        isLoading = true;
        await Future.delayed(const Duration(seconds: 3));
        yield MapError();
      }
      // await Future.delayed(const Duration(seconds: 2));
    }
  }
}

class MapRoutes {
  final List<Polyline> polylines;
  final List<Polyline> darkPolylines;

  MapRoutes({this.polylines, this.darkPolylines});
}
