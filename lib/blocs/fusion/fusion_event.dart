part of 'fusion_bloc.dart';

abstract class FusionEvent extends Equatable {
  const FusionEvent();

  @override
  List<Object> get props => [];
}

class GetFusionData extends FusionEvent {
  final Future<ShuttleUpdate> shuttleUpdate;
  GetFusionData({@required this.shuttleUpdate});

  @override
  List<Object> get props => [shuttleUpdate];
}
