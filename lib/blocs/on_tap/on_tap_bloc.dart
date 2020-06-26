import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'on_tap_event.dart';
part 'on_tap_state.dart';

class OnTapBloc extends Bloc<OnTapEvent, OnTapState> {
  @override
  OnTapState get initialState => InitialState();

  @override
  Stream<OnTapState> mapEventToState(
    OnTapEvent event,
  ) async* {
    if (event is MapStopTapped) {
      yield TappedState(stopName: event.stopName, index: event.index);
    } else if (event is TileStopTapped) {
      yield TappedState(stopName: event.stopName);
    }
  }
}
