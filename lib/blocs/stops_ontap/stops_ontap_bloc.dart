import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'stops_ontap_event.dart';
part 'stops_ontap_state.dart';

class StopsOntapBloc extends Bloc<StopsOntapEvent, StopsOntapState> {
  @override
  StopsOntapState get initialState => StopsOntapInitial();

  @override
  Stream<StopsOntapState> mapEventToState(
    StopsOntapEvent event,
  ) async* {
    if (event is MapStopTapped) {
      print('Stop: ${event.stopName} was tapped');
      yield StopTapped();
    } else if (event is TileStopTapped) {
      yield StopTapped();
    }
  }
}
