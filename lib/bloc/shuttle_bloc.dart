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
    if (event is GetShuttleMap) {
      try {
        var routes = <Polyline>[];
        var location = <Marker>[];
        var updates = <Marker>[];
        var stops = <Marker>[];
        repository.fetchRoutes().then((value) {
          routes.addAll(value);
          repository.fetchStops().then((value) {
            stops.addAll(value);
          });
        });
        repository.fetchUpdates().then((value) {
          updates.addAll(value);
        });

        repository.fetchLocation().then((value) {
          location.addAll(value);
        });
        yield ShuttleLoaded(routes, location, updates, stops);
      } catch (c) {
        print('TEST ERROR'); // TODO: ADD BETTER ERROR HERE
      }
    }
  }
}
