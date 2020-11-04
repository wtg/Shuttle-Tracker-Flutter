import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../data/fusion/fusion_socket.dart';
import '../../data/models/shuttle_eta.dart';
import '../../data/models/shuttle_update.dart';

part 'fusion_event.dart';
part 'fusion_state.dart';

class FusionBloc extends Bloc<FusionEvent, FusionState> {
  final FusionSocket fusionSocket;
  Map<ShuttleUpdate, Marker> fusionMap = {};
  dynamic currentVehicleMessage;
  dynamic currentETAMessage;

  FusionBloc({@required this.fusionSocket}) : super(FusionInitial()) {
    connect(fusionSocket: fusionSocket);
  }

  void connect({@required FusionSocket fusionSocket}) {
    print("WS is connected");
    fusionSocket.openWS();
    fusionSocket.subscribe("eta");
    fusionSocket.subscribe("vehicle_location");

    fusionSocket.channel.stream.listen((message) {
      fusionSocket.streamController.add(message);

      var response = jsonDecode(message);
      if (response['type'] == 'server_id') {
        fusionSocket.serverID = response['message'];
        print(fusionSocket.serverID);
      } else if (response['type'] == 'vehicle_location') {
        add(GetFusionVehicleData(
            shuttleUpdate: fusionSocket.handleVehicleLocations(message)));
      } else if (response['type'] == 'eta') {
        List<dynamic> body = response['message']['stop_etas'];
        if (body.isNotEmpty) {
          currentETAMessage = message;
          add(GetFusionETAData(shuttleETAs: fusionSocket.handleEtas(message)));
        }
      }
    }, onError: (error) {
      print(error);
      fusionSocket.closeWS();
    }, onDone: () async {
      print("WS is done");
      await Future.delayed(Duration(
          seconds: 3)); // Check every 3 seconds to reestablish the connection
      connect(fusionSocket: fusionSocket);
    });
  }

  @override
  Stream<FusionState> mapEventToState(
    FusionEvent event,
  ) async* {
    if (event is GetFusionVehicleData) {
      var data = await event.shuttleUpdate;
      data.setColor = Colors.white;
      if (data.routeId != null &&
          data.time.day == DateTime.now().day &&
          data.time.month == DateTime.now().month &&
          data.time.year == DateTime.now().year) {
        fusionMap[data] = data.getMarker();
        print(fusionMap.length);
      }

      var list = <Marker>[];
      fusionMap.forEach((k, v) => list.add(v));

      yield FusionVehicleLoaded(updates: list);
    } else if (event is GetFusionETAData) {
      var data = await event.shuttleETAs;
      yield FusionETALoaded(etas: data);
    }
  }

  @override
  Future<void> close() {
    fusionSocket.closeWS();
    return super.close();
  }
}
