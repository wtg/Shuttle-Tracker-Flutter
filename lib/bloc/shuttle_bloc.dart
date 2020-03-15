import 'dart:async';

import 'package:flutter_map/flutter_map.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shuttletracker/data/repository/ShuttleRepository.dart';

part 'shuttle_event.dart';
part 'shuttle_state.dart';

class ShuttleBloc extends Bloc<ShuttleEvent, ShuttleState> {
  final ShuttleRepository repository;

  ShuttleBloc(this.repository);

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
    if (event is GetShuttleMap) {
      yield ShuttleLoading();
      try {
        routes = await repository.fetchRoutes();
        stops = await repository.fetchStops();
        location = await repository.fetchLocation();
        updates = await repository.fetchUpdates();
        yield ShuttleLoaded(routes, location, updates, stops);
      } catch (e) {
        yield ShuttleError(message: e.toString());
      }
    }
  }
}
