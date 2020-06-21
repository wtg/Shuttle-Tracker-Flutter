part of 'detail_map_on_tap_bloc.dart';

abstract class DetailMapOnTapState extends Equatable {
  const DetailMapOnTapState();
}

class InitialState extends DetailMapOnTapState {
  final String stopName = '';
  @override
  List<Object> get props => [stopName];
}

class TappedState extends DetailMapOnTapState {
  final String stopName;
  final int index;

  TappedState({this.stopName, this.index});

  @override
  List<Object> get props => [stopName, index];
}
