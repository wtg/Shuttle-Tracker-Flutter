part of 'on_tap_eta_bloc.dart';

abstract class OnTapEtaState extends Equatable {
  const OnTapEtaState();
}

class OnTapEtaInitial extends OnTapEtaState {
  final String stopName = '';
  @override
  List<Object> get props => [stopName];
}

class TappedState extends OnTapEtaState {
  final int stopEta;
  final String stopName;
  final int index;

  TappedState({this.stopEta, this.stopName, this.index});

  @override
  List<Object> get props => [stopEta, stopName, index];
}
