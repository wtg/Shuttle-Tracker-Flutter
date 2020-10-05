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
import '../../global_widgets/shuttle_svg.dart';
import '../on_tap/on_tap_bloc.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final ShuttleRepository repository;
  bool isLoading = true;

  MapBloc({this.repository}) : super(MapInitial());

  List<Polyline> _createRoutes({
    @required List<ShuttleRoute> routes,
  }) {
    var polylines = <Polyline>[];

    for (var route in routes) {
      if (route.active && route.enabled) {
        polylines.add(route.getPolyline);
      }
    }
    //print("Number of routes on map: ${polylines.length}");
    return polylines;
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

  List<Marker> _createLocation({LatLng coordinates}) {
    var location = <Marker>[
      Marker(
          point: coordinates,
          width: 12.0,
          height: 12.0,
          builder: (ctx) => Image.asset('assets/img/user.png'))
    ];

    return location;
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
    var routes = <Polyline>[];
    var stops = <Marker>[];
    var updates = <Marker>[];
    var location = <Marker>[];
    LatLng center;

    var repoRoutes = await repository.getRoutes;
    var repoStops = await repository.getStops;
    var repoUpdates = await repository.getUpdates;
    var repoLocation = await repository.getLocation;
    var auxData = await repository.getAuxiliaryRouteData();
    if (event is GetMapData) {
      routes = _createRoutes(
        routes: repoRoutes,
      );

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

      location = _createLocation(coordinates: repoLocation);

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
            stops: stops,
            updates: updates,
            location: location,
            center: center,
            legend: auxData.legend);
      } else {
        isLoading = true;
        yield MapError();
      }
      // await Future.delayed(const Duration(seconds: 2));
    }
  }
}
