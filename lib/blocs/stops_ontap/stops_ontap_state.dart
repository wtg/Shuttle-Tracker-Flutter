part of 'stops_ontap_bloc.dart';

abstract class StopsOntapState extends Equatable {
  const StopsOntapState();
}

class InitialState extends StopsOntapState {
  final String stopName = "";
  @override
  List<Object> get props => [stopName];
}

class TappedState extends StopsOntapState {
  final String stopName;
  final int index;

  TappedState({this.stopName, this.index});

  @override
  List<Object> get props => [stopName, index];
}
