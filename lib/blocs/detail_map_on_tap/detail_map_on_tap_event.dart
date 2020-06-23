part of 'detail_map_on_tap_bloc.dart';

abstract class DetailMapOnTapEvent extends Equatable {
  const DetailMapOnTapEvent();
}

class MapStopTapped extends DetailMapOnTapEvent {
  final String stopName;
  final int index;

  const MapStopTapped({@required this.stopName, @required this.index});

  @override
  List<Object> get props => [stopName];
}

class TileStopTapped extends DetailMapOnTapEvent {
  final String stopName;

  const TileStopTapped({@required this.stopName});

  @override
  List<Object> get props => [stopName];
}
