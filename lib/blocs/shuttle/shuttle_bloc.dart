import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../../data/repository/shuttle_repository.dart';
import '../../models/shuttle_image.dart';
import '../../models/shuttle_route.dart';
import '../../models/shuttle_stop.dart';
import '../../models/shuttle_update.dart';
import '../on_tap_eta/on_tap_eta_bloc.dart';

part 'shuttle_event.dart';
part 'shuttle_state.dart';

// enum ShuttleEvent { getMapPageData, getRoutesPageData }

/// ShuttleBloc class
class ShuttleBloc extends Bloc<ShuttleEvent, ShuttleState> {
  /// Initialization of repository class
  final ShuttleRepository repository;

  List<Polyline> routes = [];
  List<Marker> stops = [];
  List<Marker> updates = [];
  LatLng location = LatLng(0, 0);

  final List<int> _ids = [];
  final Map<String, ShuttleImage> _legend = {};
  final Map<int, Color> _colors = {};

  bool isLoading = true;

  /// ShuttleBloc named constructor
  ShuttleBloc({this.repository}) : super(ShuttleInitial());

  List<Polyline> _createRoutes(List<ShuttleRoute> routes, List<int> _ids,
      Map<String, ShuttleImage> _legend, Map<int, Color> _colors) {
    var polylines = <Polyline>[];

    for (var route in routes) {
      if (route.active && route.enabled) {
        _legend[route.name] = ShuttleImage(svgColor: route.color);
        _ids.addAll(route.stopIds);
        polylines.add(route.getPolyline);
        for (var schedule in route.schedules) {
          _colors[schedule.routeId] = route.color;
        }
      }
    }
    //print("Number of routes on map: ${polylines.length}");
    return polylines;
  }

  List<Marker> _createStops(List<ShuttleStop> stops, BuildContext context,
      ThemeData theme, OnTapEtaBloc bloc, dynamic animatedMapMove) {
    var markers = <Marker>[];

    for (var stop in stops) {
      if (_ids.contains(stop.id)) {
        markers.add(stop.getEtaMarker(
          animatedMapMove: animatedMapMove,
          context: context,
          bloc: bloc,
        )); //bloc: bloc));                      //Ask Sam why this is commented
      }
    }
    //print("Number of stops on map: ${markers.length}");
    return markers;
  }

  List<Marker> _createUpdates(List<ShuttleUpdate> updates, BuildContext context,
      Map<int, Color> colors, dynamic animatedMapMove) {
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

  @override
  Stream<ShuttleState> mapEventToState(ShuttleEvent event) async* {
    var repoRoutes = await repository.getRoutes;
    var repoStops = await repository.getStops;
    var repoUpdates = await repository.getUpdates;
    if (event is GetMapPageData) {
      if (isLoading) {
        yield ShuttleLoading();
        isLoading = false;
      } else {
        /// Poll every 3ish seconds
        await Future.delayed(const Duration(seconds: 2));
      }

      routes.clear();
      stops.clear();
      updates.clear();
      _ids.clear();
      _legend.clear();
      _colors.clear();

      location = await repository.getLocation;
      routes = _createRoutes(repoRoutes, _ids, _legend, _colors);

      stops = _createStops(repoStops, event.context, event.theme, event.bloc,
          event.animatedMapMove);
      updates = _createUpdates(
          repoUpdates, event.context, _colors, event.animatedMapMove);

      if (repository.getIsConnected) {
        yield ShuttleLoaded(
            routes: routes, location: location, updates: updates, stops: stops);
      } else {
        isLoading = true;
        yield ShuttleError(message: 'NETWORK ISSUE');
      }
      await Future.delayed(const Duration(seconds: 2));
    } else {
      yield ShuttleLoading();

      location = await repository.getLocation;
      routes = _createRoutes(await repoRoutes, _ids, _legend, _colors);

      stops = _createStops(await repoStops, event.context, event.theme,
          event.bloc, event.animatedMapMove);
      updates = _createUpdates(
          await repoUpdates, event.context, _colors, event.animatedMapMove);

      yield RoutesPageLoaded(
          routes: repoRoutes,
          location: location,
          updates: repoUpdates,
          stops: repoStops);
    }
  }
}
