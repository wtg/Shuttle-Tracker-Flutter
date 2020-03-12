import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shuttle_event.dart';
part 'shuttle_state.dart';

class ShuttleBloc extends Bloc<ShuttleEvent, ShuttleState> {
  @override
  ShuttleState get initialState => ShuttleInitial();

  @override
  Stream<ShuttleState> mapEventToState(
    ShuttleEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
