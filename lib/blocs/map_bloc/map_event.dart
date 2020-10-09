part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class GetMapData extends MapEvent {
  final BuildContext context;
  final dynamic animatedMapMove;
  final OnTapBloc bloc;
  const GetMapData({this.context, this.animatedMapMove, this.bloc});
}
