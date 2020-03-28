import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/repository/ShuttleRepository.dart';
import '../models/ShuttleImage.dart';


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
      await Future.delayed(const Duration(seconds: 5));
    } else if (event is RefreshShuttleMap) {
      await Future.delayed(const Duration(seconds: 5));

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
