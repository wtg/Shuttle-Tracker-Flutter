part of 'shuttle_bloc.dart';

abstract class ShuttleState extends Equatable {
  const ShuttleState();
}

/// This class represents what user will see intially
class ShuttleInitial extends ShuttleState {
  const ShuttleInitial();
  @override
  List<Object> get props => [];
}

/// This class represents what user will see when fetching data
class ShuttleLoading extends ShuttleState {
  const ShuttleLoading();
  @override
  List<Object> get props => [];
}

/// This class represents what user will see when data is fetched
class ShuttleLoaded extends ShuttleState {
  final List<Polyline> routes;
  final List<Marker> location;
  final List<Marker> updates;
  final List<Marker> stops;
  final Map<String, ShuttleImage> mapkey;

  const ShuttleLoaded(
      this.routes, this.location, this.updates, this.stops, this.mapkey);
  @override
  List<Object> get props => [routes, location, updates, stops, mapkey];
}

// This class represents what user will see when there is an error
class ShuttleError extends ShuttleState {
  final String message;
  const ShuttleError({this.message});
  @override
  List<Object> get props => [message];
}
