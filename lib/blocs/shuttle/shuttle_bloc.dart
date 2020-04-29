import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong/latlong.dart';

import '../../data/repository/shuttle_repository.dart';

part 'shuttle_event.dart';
part 'shuttle_state.dart';

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
    if (event is GetShuttleMap) {
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
            routes: routes, location: location, updates: updates, stops: stops);
      } else {
        isLoading = true;
        yield ShuttleError(message: "NETWORK ISSUE");
      }
      await Future.delayed(const Duration(seconds: 3));
    } else if (event is GetSettingsList) {
      routes.clear();
      stops.clear();
      updates.clear();

      location = await repository.getLocation;
      routes = await repository.getRoutes;
      stops = await repository.getStops;
      updates = await repository.getUpdates;

      yield ShuttleLoaded(
          routes: routes, location: location, updates: updates, stops: stops);
    }
  }
}
