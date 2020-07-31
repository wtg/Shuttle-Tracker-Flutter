part of 'on_tap_bloc.dart';

abstract class OnTapEvent extends Equatable {
  final String stopName;
  const OnTapEvent({@required this.stopName});
}

class MapStopTapped extends OnTapEvent {
  final int index;

  const MapStopTapped({@required stopName, @required this.index})
      : super(stopName: stopName);

  @override
  List<Object> get props => [stopName];
}

class TileStopTapped extends OnTapEvent {
  const TileStopTapped({
    @required stopName,
  }) : super(stopName: stopName);

  @override
  List<Object> get props => [stopName];
}
