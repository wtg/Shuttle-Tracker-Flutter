part of 'updates_bloc.dart';

abstract class UpdatesState extends Equatable {
  const UpdatesState();
}

class UpdatesInitial extends UpdatesState {
  @override
  List<Object> get props => [];
}
