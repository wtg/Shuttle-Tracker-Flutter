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

  /// ShuttleBloc named constructor
  ShuttleBloc({this.repository});

  @override
  ShuttleState get initialState => ShuttleInitial();

  @override
  Stream<ShuttleState> mapEventToState(
    ShuttleEvent event,
  ) async* {
    var routes = <Polyline>[];
    var location = <Marker>[];
    var updates = <Marker>[];
    var stops = <Marker>[];
    var mapkey = <Widget>[];
    if (event is GetShuttleMap) {
      yield ShuttleLoading();
      try {
        routes = await repository.getRoutes;
        stops = await repository.getStops;
        location = await repository.getLocation;
        updates = await repository.getUpdates;
        mapkey = repository.getMapkey;
        yield ShuttleLoaded(routes, location, updates, stops, mapkey);
      } catch (e) {
        yield ShuttleError(message: e.toString());
      }
    } else if (event is RefreshShuttleMap) {
      await new Future.delayed(const Duration(seconds: 5));
      try {
        routes = await repository.getRoutes;
        stops = await repository.getStops;
        location = await repository.getLocation;
        updates = await repository.getUpdates;
        mapkey = repository.getMapkey;
        yield ShuttleLoaded(routes, location, updates, stops, mapkey);
      } catch (e) {
        yield ShuttleError(message: e.toString());
      }
    }
  }

}
