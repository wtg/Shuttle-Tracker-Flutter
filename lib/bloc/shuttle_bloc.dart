import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/repository/shuttle_repository.dart';
import '../models/shuttle_image.dart';

part 'shuttle_event.dart';
part 'shuttle_state.dart';

/// ShuttleBloc class
class ShuttleBloc extends Bloc<ShuttleEvent, ShuttleState> {
  /// Initialization of repository class
  final ShuttleRepository repository;
  List<Polyline> routes = [];
  List<Marker> location = [];
  List<Marker> updates = [];
  List<Marker> stops = [];
  Map<String, ShuttleImage> mapkey = {};
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
        await Future.delayed(const Duration(seconds: 5));
      }

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
        yield ShuttleLoaded(
            routes: routes,
            location: location,
            updates: updates,
            stops: stops,
            mapkey: mapkey);
      } else {
        isLoading = true;
        yield ShuttleError(message: "NETWORK ISSUE");
      }
      await Future.delayed(const Duration(seconds: 5));
    }
  }
}
