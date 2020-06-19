part of 'stops_ontap_bloc.dart';

abstract class StopsOntapState extends Equatable {
  const StopsOntapState();
}

class StopsOntapInitial extends StopsOntapState {
  @override
  List<Object> get props => [];
}

class StopTapped extends StopsOntapState {
  final bool isTapped = true;

  @override
  List<Object> get props => [isTapped];
}

class StopNotTapped extends StopsOntapState {
  final bool isTapped = false;

  @override
  List<Object> get props => [isTapped];
}
