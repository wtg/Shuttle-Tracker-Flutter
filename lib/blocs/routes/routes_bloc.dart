import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:latlong/latlong.dart';

import '../../data/repository/shuttle_repository.dart';
import '../../models/shuttle_route.dart';
import '../../models/shuttle_stop.dart';
import '../../models/shuttle_update.dart';

part 'routes_state.dart';

enum RoutesEvent { getRoutesPageData }

/// RoutesBloc class
class RoutesBloc extends Bloc<RoutesEvent, RoutesState> {
  /// Initialization of repository class
  final ShuttleRepository repository;
  List<ShuttleRoute> routes = [];
  List<ShuttleStop> stops = [];
  List<ShuttleUpdate> updates = [];
  LatLng location = LatLng(0, 0);

  bool isLoading = true;

  /// RoutesBloc named constructor
  RoutesBloc({this.repository}) : super(RoutesInitial());

  @override
  Stream<RoutesState> mapEventToState(RoutesEvent event) async* {
    switch (event) {
      case RoutesEvent.getRoutesPageData:
        yield RoutesLoading();

        location = await repository.getLocation;
        routes = await repository.getRoutes;
        stops = await repository.getStops;
        updates = await repository.getUpdates;

        yield RoutesLoaded(
            routes: routes, location: location, updates: updates, stops: stops);
        break;
    }
  }
}
