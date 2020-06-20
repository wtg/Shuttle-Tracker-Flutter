import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'stops_ontap_event.dart';
part 'stops_ontap_state.dart';

class StopsOntapBloc extends Bloc<StopsOntapEvent, String> {
  @override
  String get initialState => "";

  @override
  Stream<String> mapEventToState(
    StopsOntapEvent event,
  ) async* {
    if (event is MapStopTapped) {
      yield event.stopName;
    } else if (event is TileStopTapped) {
      yield event.stopName;
    }
  }
}
