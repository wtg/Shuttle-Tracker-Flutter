import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong/latlong.dart';

import 'package:flutter_shuttletracker/data/repository/shuttle_repository.dart';

part 'shuttle_state.dart';

enum ShuttleEvent { getShuttleMap, getSettingsList }

/// ShuttleBloc class
class ShuttleBloc extends Bloc<ShuttleEvent, ShuttleState> {
  /// Initialization of repository class
  final ShuttleRepository repository;
  List<dynamic> routes = [];
  List<dynamic> stops = [];
  List<dynamic> updates = [];
  LatLng location = LatLng(0, 0);

  bool isLoading = true;

  /// ShuttleBloc named constructor
  ShuttleBloc({this.repository});

  @override
  ShuttleState get initialState => ShuttleInitial();

  @override
  Stream<ShuttleState> mapEventToState(
    ShuttleEvent event,
  ) async* {
    switch (event) {
      case ShuttleEvent.getShuttleMap:
        if (isLoading) {
          yield ShuttleLoading();
          isLoading = false;
        } else {
          /// Poll every 3ish seconds
          await Future.delayed(const Duration(seconds: 3));
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
          yield ShuttleError(message: "NETWORK ISSUE");
        }
        await Future.delayed(const Duration(seconds: 3));
        break;
      case ShuttleEvent.getSettingsList:
        location = await repository.getLocation;
        routes = await repository.getRoutes;
        stops = await repository.getStops;
        updates = await repository.getUpdates;

        yield ShuttleLoaded(
            routes: routes, location: location, updates: updates, stops: stops);
        break;
      /*
      if (repository.getIsConnected) {
        yield ShuttleLoaded(
            routes: routes, location: location, updates: updates, stops: stops);
      } else {
        await Future.delayed(const Duration(seconds: 5));
        yield ShuttleError(message: "NETWORK ISSUE");
      }
      */
    }
  }
}
