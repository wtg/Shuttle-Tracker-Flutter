part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {
  @override
  List<Object> get props => [];
}

class MapLoading extends MapState {
  @override
  List<Object> get props => [];
}

class MapLoaded extends MapState {
  final List<Polyline> routes;
  final List<Marker> stops;
  final List<Marker> updates;
  final List<Marker> location;
  final LatLng center;
  final Map<String, ShuttleArrow> legend;

  const MapLoaded(
      {@required this.routes,
      @required this.stops,
      @required this.updates,
      @required this.location,
      @required this.center,
      @required this.legend});

  @override
  List<Object> get props => [routes, stops, updates, location, center];
}

class MapError extends MapState {
  @override
  List<Object> get props => [];
}
