part of 'on_tap_bloc.dart';

abstract class OnTapState extends Equatable {
  const OnTapState();
}

class InitialState extends OnTapState {
  final String stopName = '';
  @override
  List<Object> get props => [stopName];
}

class TappedState extends OnTapState {
  final String stopName;
  final int index;

  TappedState({this.stopName, this.index});

  @override
  List<Object> get props => [stopName, index];
}
