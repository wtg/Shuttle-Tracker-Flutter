import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'on_tap_eta_event.dart';
part 'on_tap_eta_state.dart';

class OnTapEtaBloc extends Bloc<OnTapEtaEvent, OnTapEtaState> {
  OnTapEtaBloc() : super(OnTapEtaInitial());

  @override
  Stream<OnTapEtaState> mapEventToState(
    OnTapEtaEvent event,
  ) async* {
    if (event is MapStopTapped) {
      yield TappedState(stopName: event.stopName, stopEta: event.eta,
          index: event.index);
  }
}
}