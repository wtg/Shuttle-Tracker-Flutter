part of 'on_tap_eta_bloc.dart';

abstract class OnTapEtaEvent extends Equatable {
  final String stopName;
  final int eta;
  const OnTapEtaEvent({@required this.stopName, @required this.eta});
}

class MapStopTapped extends OnTapEtaEvent {
  final int index;

  const MapStopTapped({@required name, @required stopEta,
    @required this.index}) : super(stopName: name, eta: stopEta);

  @override
  List<Object> get props => [eta];
}
