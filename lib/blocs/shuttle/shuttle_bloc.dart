import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:latlong/latlong.dart';

import '../../data/repository/shuttle_repository.dart';
import '../../models/shuttle_route.dart';
import '../../models/shuttle_stop.dart';
import '../../models/shuttle_update.dart';

part 'shuttle_state.dart';

enum ShuttleEvent { getShuttleMap, getRoutes }

/// ShuttleBloc class
class ShuttleBloc extends Bloc<ShuttleEvent, ShuttleState> {
  /// Initialization of repository class
  final ShuttleRepository repository;
  List<ShuttleRoute> routes = [];
  List<ShuttleStop> stops = [];
  List<ShuttleUpdate> updates = [];
  LatLng location = LatLng(0, 0);

  bool isLoading = true;

  /// ShuttleBloc named constructor
  ShuttleBloc({this.repository});

  @override
  ShuttleState get initialState => ShuttleInitial();

  @override
  Stream<ShuttleState> mapEventToState(ShuttleEvent event) async* {
    switch (event) {
      case ShuttleEvent.getShuttleMap:
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

        location = await repository.getLocation;
        routes = await repository.getRoutes;
        stops = await repository.getStops;
        updates = await repository.getUpdates;

        if (repository.getIsConnected) {
          yield ShuttleLoaded(
              routes: routes,
              location: location,
              updates: updates,
              stops: stops);
        } else {
          isLoading = true;
          yield ShuttleError(message: 'NETWORK ISSUE');
        }
        await Future.delayed(const Duration(seconds: 2));
        break;
      case ShuttleEvent.getRoutes:
        yield ShuttleLoading();

        location = await repository.getLocation;
        routes = await repository.getRoutes;
        stops = await repository.getStops;
        updates = await repository.getUpdates;

        yield ShuttleLoaded(
            routes: routes, location: location, updates: updates, stops: stops);
        break;
    }
  }
}
