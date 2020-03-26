import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/repository/ShuttleRepository.dart';

part 'shuttle_event.dart';
part 'shuttle_state.dart';

/// ShuttleBloc class
class ShuttleBloc extends Bloc<ShuttleEvent, ShuttleState> {
  /// Initialization of repository class
  final ShuttleRepository repository;
  var routes = <Polyline>[];
  var location = <Marker>[];
  var updates = <Marker>[];
  var stops = <Marker>[];
  var mapkey = <Widget>[];

  /// ShuttleBloc named constructor
  ShuttleBloc({this.repository});

  @override
  ShuttleState get initialState => ShuttleInitial();

  @override
  Stream<ShuttleState> mapEventToState(
    ShuttleEvent event,
  ) async* {
    if (event is GetShuttleMap) {
      /*TODO: Figure out way to maintain ShuttleError without having to reload the state
       (i.e. have a ciruclar indicator during period of error)
      */
      yield ShuttleLoading();
      location = await repository.getLocation;
      routes = await repository.getRoutes;
      stops = await repository.getStops;
      updates = await repository.getUpdates;
      mapkey = repository.getMapkey;
      if (repository.getIsConnected) {
        yield ShuttleLoaded(routes, location, updates, stops, mapkey);
      } else {
        yield ShuttleError(message: "NETWORK ISSUE");
      }
      await new Future.delayed(const Duration(seconds: 5));
    } else if (event is RefreshShuttleMap) {
      await new Future.delayed(const Duration(seconds: 5));

      // TODO: CLEAR UP THIS CODE LATER TO HAVE LESS LINES
      routes.clear();
      stops.clear();
      location.clear();
      updates.clear();
      mapkey.clear();
      location = await repository.getLocation;
      routes = await repository.getRoutes;
      stops = await repository.getStops;
      updates = await repository.getUpdates;
      mapkey = repository.getMapkey;

      if (repository.getIsConnected) {
        yield ShuttleLoaded(routes, location, updates, stops, mapkey);
      } else {
        yield ShuttleError(message: "NETWORK ISSUE");
      }
    }
  }
}
