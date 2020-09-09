part of 'on_tap_eta_bloc.dart';

abstract class OnTapEtaState extends Equatable {
  const OnTapEtaState();
}

class OnTapEtaInitial extends OnTapEtaState {
  final String stopName = '';
  @override
  List<Object> get props => [stopName];
}

class MainTappedState extends OnTapEtaState {
  final double stopEta;
  final String stopName;
  final int index;

  MainTappedState({this.stopEta, this.stopName, this.index});

  @override
  List<Object> get props => [stopEta, stopName, index];
}
