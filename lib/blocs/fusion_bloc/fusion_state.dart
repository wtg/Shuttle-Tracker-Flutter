part of 'fusion_bloc.dart';

abstract class FusionState extends Equatable {
  const FusionState();

  @override
  List<Object> get props => [];
}

class FusionInitial extends FusionState {}

class FusionVehicleLoaded extends FusionState {
  final List<Marker> updates;

  FusionVehicleLoaded({@required this.updates});

  @override
  List<Object> get props => [updates];
}

class FusionETALoaded extends FusionState {
  final List<ShuttleETA> etas;
    final List<Marker> updates;
  FusionETALoaded({@required this.etas, this.updates});

  @override
  List<Object> get props => [etas, updates];
}
