part of 'fusion_bloc.dart';

abstract class FusionState extends Equatable {
  const FusionState();

  @override
  List<Object> get props => [];
}

class FusionInitial extends FusionState {}

class FusionLoaded extends FusionState {}
