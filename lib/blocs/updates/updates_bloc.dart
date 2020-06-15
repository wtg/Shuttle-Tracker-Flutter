import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'updates_state.dart';

enum UpdatesEvent {getUpdates}

class UpdatesBloc extends Bloc<UpdatesEvent, UpdatesState> {
  @override
  UpdatesState get initialState => UpdatesInitial();

  @override
  Stream<UpdatesState> mapEventToState(
    UpdatesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
