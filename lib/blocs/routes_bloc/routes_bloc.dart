import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong/latlong.dart';

import '../../data/models/shuttle_route.dart';
import '../../data/models/shuttle_stop.dart';
import '../../data/models/shuttle_update.dart';
import '../../data/repository/shuttle_repository.dart';

part 'routes_state.dart';

enum RoutesEvent { getRoutesPageData }

/// RoutesBloc class
class RoutesBloc extends Bloc<RoutesEvent, RoutesState> {
  /// Initialization of repository class
  final ShuttleRepository repository;
  List<ShuttleRoute> routes = [];
  List<ShuttleRoute> darkRoutes = [];
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

        routes = await repository.getRoutes;
        darkRoutes = await repository.getDarkRoutes();
        stops = await repository.getStops;
        updates = await repository.getUpdates;

        yield RoutesLoaded(
            routes: routes,
            darkRoutes: darkRoutes,
            location: location,
            updates: updates,
            stops: stops);
        break;
    }
  }
}
