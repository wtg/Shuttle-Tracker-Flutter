import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'detail_map_on_tap_event.dart';
part 'detail_map_on_tap_state.dart';

class DetailMapOnTapBloc
    extends Bloc<DetailMapOnTapEvent, DetailMapOnTapState> {
  @override
  DetailMapOnTapState get initialState => InitialState();

  @override
  Stream<DetailMapOnTapState> mapEventToState(
    DetailMapOnTapEvent event,
  ) async* {
    if (event is MapStopTapped) {
      yield TappedState(stopName: event.stopName, index: event.index);
    } else if (event is TileStopTapped) {
      yield TappedState(stopName: event.stopName);
    }
  }
}
