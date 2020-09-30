import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../data/fusion/fusion_socket.dart';

part 'fusion_event.dart';
part 'fusion_state.dart';

class FusionBloc extends Bloc<FusionEvent, FusionState> {
  final FusionSocket fusionSocket;
  FusionBloc({@required this.fusionSocket}) : super(FusionInitial()) {
    fusionSocket.openWS();
    fusionSocket.subscribe("eta");
    fusionSocket.subscribe("vehicle_location");

    fusionSocket.channel.stream.listen((message) {
      fusionSocket.streamController.add(message);
      // {"type":"server_id","message":"0ad35438-58bd-11ea-a696-0242ac110017"}
      var response = jsonDecode(message);
      if (response['type'] == 'server_id') {
        fusionSocket.serverID = response['message'];
        print(fusionSocket.serverID);
        return;
      } else if (response['type'] == 'vehicle_location') {
        add(GetFusionData());
        fusionSocket.handleVehicleLocations(message);
      }
    });
  }

  @override
  Stream<FusionState> mapEventToState(
    FusionEvent event,
  ) async* {
  if(event is GetFusionData){
    print("NEW DATA RECIEVED");
    yield FusionLoaded();
  }


    // TODO: implement mapEventToState
  }

  @override
  Future<void> close() {
    fusionSocket.closeWS();
    return super.close();
  }
}
