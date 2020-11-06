part of 'fusion_bloc.dart';

abstract class FusionEvent extends Equatable {
  const FusionEvent();

  @override
  List<Object> get props => [];
}

class GetFusionVehicleData extends FusionEvent {
  final Future<ShuttleUpdate> shuttleUpdate;
  GetFusionVehicleData({@required this.shuttleUpdate});

  @override
  List<Object> get props => [shuttleUpdate];
}

class GetFusionETAData extends FusionEvent {
  final List<ShuttleETA> shuttleETAs;
  GetFusionETAData({@required this.shuttleETAs});

  @override
  List<Object> get props => [shuttleETAs];
}

class GetShuttleColorData extends FusionEvent {
  final Map<int, Color> shuttleColors;
  GetShuttleColorData({@required this.shuttleColors});

  @override
  List<Object> get props => [shuttleColors];
}
