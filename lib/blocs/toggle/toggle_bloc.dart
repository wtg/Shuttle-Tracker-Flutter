import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_shuttletracker/models/shuttle_route.dart';

enum ToggleEvent {toggle}

class ToggleBloc extends Bloc<ToggleEvent, ShuttleRoute> {
  @override
  ShuttleRoute get initialState => ShuttleRoute();

  @override
  Stream<ShuttleRoute> mapEventToState(
    ToggleEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
