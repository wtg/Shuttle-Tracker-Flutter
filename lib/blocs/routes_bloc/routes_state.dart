part of 'routes_bloc.dart';

abstract class RoutesState extends Equatable {
  const RoutesState();
}

/// This class represents what user will see intially
class RoutesInitial extends RoutesState {
  const RoutesInitial();
  @override
  List<Object> get props => [];
}

/// This class represents what user will see when fetching data
class RoutesLoading extends RoutesState {
  const RoutesLoading();
  @override
  List<Object> get props => [];
}

/// This class represents what user will see when data is fetched
class RoutesLoaded extends RoutesState {
  final List<ShuttleRoute> routes;
  final List<ShuttleRoute> darkRoutes;
  final LatLng location;
  final List<ShuttleUpdate> updates;
  final List<ShuttleStop> stops;

  const RoutesLoaded(
      {this.routes, this.darkRoutes, this.location, this.updates, this.stops});
  @override
  List<Object> get props => [routes, location, updates, stops];
}

// This class represents what user will see when there is an error
class RoutesError extends RoutesState {
  final String message;
  const RoutesError({this.message});
  @override
  List<Object> get props => [message];
}
