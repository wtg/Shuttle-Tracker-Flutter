part of 'shuttle_bloc.dart';

abstract class ShuttleState extends Equatable {
  const ShuttleState();
}

class ShuttleInitial extends ShuttleState {
  @override
  List<Object> get props => [];
}
